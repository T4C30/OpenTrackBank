import os
import sqlite3
from datetime import date, timedelta
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
from werkzeug.security import generate_password_hash, check_password_hash

import plaid
from plaid.api import plaid_api
from plaid.model.link_token_create_request import LinkTokenCreateRequest
from plaid.model.link_token_create_request_user import LinkTokenCreateRequestUser
from plaid.model.products import Products
from plaid.model.country_code import CountryCode
from plaid.model.item_public_token_exchange_request import ItemPublicTokenExchangeRequest
from plaid.model.accounts_balance_get_request import AccountsBalanceGetRequest
from plaid.model.transactions_get_request import TransactionsGetRequest
from plaid.model.transactions_get_request_options import TransactionsGetRequestOptions

load_dotenv()

app = Flask(__name__)
CORS(app)

# --- CONFIGURACIÓN DE PLAID ---
PLAID_CLIENT_ID = os.getenv('PLAID_CLIENT_ID')
PLAID_SECRET = os.getenv('PLAID_SECRET')
PLAID_ENV = os.getenv('PLAID_ENV', 'sandbox')

environments = {
    'sandbox': plaid.Environment.Sandbox,
    'production': plaid.Environment.Production,
}

configuration = plaid.Configuration(
    host=environments[PLAID_ENV],
    api_key={'clientId': PLAID_CLIENT_ID, 'secret': PLAID_SECRET}
)
api_client = plaid.ApiClient(configuration)
client = plaid_api.PlaidApi(api_client)

# --- BASE DE DATOS SQLITE ---
DB_NAME = "database.db"


def init_db():
    """Inicializa la base de datos y crea la tabla si no existe."""
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
        )
    ''')
    c.execute('''
        CREATE TABLE IF NOT EXISTS plaid_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            item_id TEXT UNIQUE NOT NULL,
            access_token TEXT NOT NULL,
            institution_name TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

            FOREIGN KEY(user_id) REFERENCES users(id)
        )
    ''')
    conn.commit()
    conn.close()


def get_db_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row  # Para poder acceder a las columnas por nombre
    return conn


# Inicializamos la DB al arrancar
init_db()


# ==========================================
# ENDPOINTS DE USUARIO (BASE DE DATOS)
# ==========================================

@app.route('/api/register', methods=['POST'])
def register_user():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({'error': 'Faltan credenciales'}), 400

    hashed_password = generate_password_hash(password)

    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, hashed_password))
        conn.commit()
        user_id = cursor.lastrowid
        return jsonify({'message': 'Usuario creado', 'user_id': user_id}), 201
    except sqlite3.IntegrityError:
        return jsonify({'error': 'El usuario ya existe'}), 409
    finally:
        conn.close()


@app.route('/api/login', methods=['POST'])
def login_user():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    conn = get_db_connection()
    user = conn.execute("SELECT * FROM users WHERE username = ?", (username,)).fetchone()
    conn.close()

    if user and check_password_hash(user['password'], password):
        return jsonify({
            'message': 'Login exitoso',
            'user_id': user['id'],
            'has_bank_linked': user['access_token'] is not None
        }), 200
    else:
        return jsonify({'error': 'Credenciales incorrectas'}), 401


# ==========================================
# ENDPOINTS DE PLAID
# ==========================================

@app.route('/api/create_link_token', methods=['POST'])
def create_link_token():
    user_id = request.json.get('user_id')
    if not user_id:
        return jsonify({'error': 'user_id es requerido'}), 400

    try:
        request_data = LinkTokenCreateRequest(
            products=[Products('transactions')],
            client_name="Mi App Flutter",
            country_codes=[CountryCode('ES')],
            language='es',
            user=LinkTokenCreateRequestUser(client_user_id=str(user_id))
        )
        response = client.link_token_create(request_data)
        return jsonify(response.to_dict())
    except plaid.ApiException as e:
        return jsonify({'error': str(e)}), 400


@app.route('/api/set_access_token', methods=['POST'])
def get_access_token():
    public_token = request.json.get('public_token')
    user_id = request.json.get('user_id')

    if not public_token or not user_id:
        return jsonify({'error': 'Faltan datos'}), 400

    try:
        # Intercambiar public_token por access_token
        exchange_request = ItemPublicTokenExchangeRequest(
            public_token=public_token
        )

        exchange_response = client.item_public_token_exchange(
            exchange_request
        )

        access_token = exchange_response['access_token']
        item_id = exchange_response['item_id']

        # Obtener info de la institución
        item_response = client.item_get(
            ItemGetRequest(access_token=access_token)
        )

        institution_id = item_response['item']['institution_id']

        institution_name = None

        if institution_id:
            institution_response = client.institutions_get_by_id(
                InstitutionsGetByIdRequest(
                    institution_id=institution_id,
                    country_codes=['US']
                )
            )

            institution_name = institution_response['institution']['name']

        # Guardar NUEVO banco
        conn = get_db_connection()

        conn.execute("""
            INSERT INTO plaid_items (
                user_id,
                access_token,
                item_id,
                institution_name
            )
            VALUES (?, ?, ?, ?)
        """, (
            user_id,
            access_token,
            item_id,
            institution_name
        ))

        conn.commit()
        conn.close()

        return jsonify({
            'message': 'Banco enlazado correctamente'
        })

    except plaid.ApiException as e:
        return jsonify({'error': str(e)}), 400


@app.route('/api/balances', methods=['POST'])
def get_balances():
    user_id = request.json.get('user_id')

    conn = get_db_connection()
    user = conn.execute("SELECT access_token FROM users WHERE id = ?", (user_id,)).fetchone()
    conn.close()

    if not user or not user['access_token']:
        return jsonify({'error': 'El usuario no tiene un banco enlazado'}), 404

    try:
        request_data = AccountsBalanceGetRequest(access_token=user['access_token'])
        response = client.accounts_balance_get(request_data)
        return jsonify(response.to_dict())
    except plaid.ApiException as e:
        return jsonify({'error': str(e)}), 400


@app.route('/api/transactions', methods=['POST'])
def get_transactions():
    user_id = request.json.get('user_id')

    conn = get_db_connection()
    user = conn.execute("SELECT access_token FROM users WHERE id = ?", (user_id,)).fetchone()
    conn.close()

    if not user or not user['access_token']:
        return jsonify({'error': 'El usuario no tiene un banco enlazado'}), 404

    try:
        # Obtener transacciones de los últimos 30 días
        start_date = date.today() - timedelta(days=30)
        end_date = date.today()

        request_data = TransactionsGetRequest(
            access_token=user['access_token'],
            start_date=start_date,
            end_date=end_date,
            options=TransactionsGetRequestOptions(count=50)  # Límite de 50 transacciones
        )
        response = client.transactions_get(request_data)
        return jsonify(response.to_dict())
    except plaid.ApiException as e:
        return jsonify({'error': str(e)}), 400


if __name__ == '__main__':
    app.run(port=5000, debug=True)