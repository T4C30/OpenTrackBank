# Instalacion

## Prerrequisitos
- Java 25 JDK instalado.
- Maven 3.6+ instalado.
- Credenciales de Plaid API (obtener de https://plaid.com/).

## Pasos de Despliegue

### 1. Clonación del Repositorio
```bash
git clone <url-del-repositorio>
cd OpenTrackBank
```

### 2. Configuración
- Edite `src/main/java/org/taulyd/torrente/PlaidCliente.java` y agregue sus credenciales de Plaid:
  ```java
  private static final String CLIENTID = "su-client-id";
  private static final String SECRET = "su-secret";
  ```

### 3. Compilación
```bash
mvn clean compile
```

### 4. Empaquetado
```bash
mvn package
```
Esto genera `target/OTB-0.0.0.1.jar` con todas las dependencias incluidas.

### 5. Ejecución
```bash
java -jar target/OTB-0.0.0.1.jar
```



# Uso / Flujo Principal

## Pantalla de sesion

Se pedira iniciar por contraseña o por clave.

En el caso de que no se tenga se generara la clave o se pedira escribir la contraseña.

Si tienes hecho registro se podra iniciar por clave publica o por la contraseña guardada



## Pantalla Principal

Se mostrara la "Cargando" hasta que cargue en este caso el sandbox.
Despues podra y con las flechas revisando cada cuenta que haya, debajo aparecera el resumen de la ultima semana.

Habra una rueda de ajuste para llevar a la pantalla de ajustes


## Pantalla de ajuste

Habra para generar una nueva clave publica como copia de seguridad.

Un ChoiceBox para cambio de tema entre claro y oscuro.

Y sin implementar el idioma.


Puedes volver a la pantalla anterior pulsando a la X de arriba derecha
