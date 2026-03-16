package org.taulyd.torrente;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import com.plaid.client.ApiClient;
import com.plaid.client.model.AccountBalance;
import com.plaid.client.model.AccountBase;
import com.plaid.client.model.AccountsBalanceGetRequest;
import com.plaid.client.model.AccountsGetResponse;
import com.plaid.client.model.ItemPublicTokenExchangeRequest;
import com.plaid.client.model.ItemPublicTokenExchangeResponse;
import com.plaid.client.model.Products;
import com.plaid.client.model.SandboxPublicTokenCreateRequest;
import com.plaid.client.model.SandboxPublicTokenCreateResponse;
import com.plaid.client.model.Transaction;
import com.plaid.client.model.TransactionsGetRequest;
import com.plaid.client.model.TransactionsGetResponse;
import com.plaid.client.request.PlaidApi;

import retrofit2.Response;




public class PlaidCliente {
    private static final String CLIENTID = "";
    private static final String SECRET = "";
    public record Cuenta(String nombre, Double actual, Double disponible) {}
    public record Transaccion(String ordenTransaccion, LocalDate fecha, Double cantidad){}
    private static PlaidApi clientePlaid;

    private static String tokenAcceso(){
        HashMap<String, String> apis = new HashMap<>();
        apis.put("clientId", CLIENTID);
        apis.put("secret", SECRET );
        apis.put("plaidVersion", "2020-09-14");

        // Configurar el cliente de Plaid con tus credenciales
        ApiClient apiClient = new ApiClient(apis);
        apiClient.setPlaidAdapter(ApiClient.Sandbox);
        clientePlaid = apiClient.createService(PlaidApi.class);
        
        try {
            // A. Crear el token público de prueba
            SandboxPublicTokenCreateRequest sandboxRequest = new SandboxPublicTokenCreateRequest()
                .institutionId("ins_109511")
                .initialProducts(Arrays.asList(Products.TRANSACTIONS));

            Response<SandboxPublicTokenCreateResponse> sandboxResp = clientePlaid
                .sandboxPublicTokenCreate(sandboxRequest)
                .execute();

            String publicToken = sandboxResp.body().getPublicToken();

            // B. Intercambiarlo
            ItemPublicTokenExchangeRequest exchangeRequest = new ItemPublicTokenExchangeRequest()
                .publicToken(publicToken);

            Response<ItemPublicTokenExchangeResponse> exchangeResp = clientePlaid
                .itemPublicTokenExchange(exchangeRequest)
                .execute();

            return exchangeResp.body().getAccessToken();
        } catch (IOException e) {
            return "";
        }
  
    }

    public static List<Cuenta> recuperarCuentas() {
        List<Cuenta> cuentas = List.of();
        try {
            AccountsBalanceGetRequest balanceRequest = new AccountsBalanceGetRequest().accessToken(tokenAcceso());
            
            Response<AccountsGetResponse> balanceResponse = clientePlaid.accountsBalanceGet(balanceRequest).execute();
            
            if (balanceResponse.isSuccessful()) {
                List<AccountBase> cuentasBase = balanceResponse.body().getAccounts();
                if (cuentasBase != null) {
                    cuentas =cuentasBase.stream().map(c -> {
                        AccountBalance balance = c.getBalances();
                        
                        return new Cuenta(c.getName(), balance.getCurrent(), balance.getAvailable());
                    }).toList();
                }
                return cuentas;
            }
        } catch (IOException e) {
            return cuentas;
        }
        return cuentas;
    }


    public static List<Transaccion> recuperarTransacciones() {
        LocalDate startDate = LocalDate.now().minusDays(7);
        LocalDate endDate = LocalDate.now();
        List<Transaccion> transaciones = List.of();


        TransactionsGetRequest transRequest = new TransactionsGetRequest()
            .accessToken(tokenAcceso())
            .startDate(startDate)
            .endDate(endDate);

        try {
            Response<TransactionsGetResponse> transResponse = clientePlaid.transactionsGet(transRequest).execute();
            LocalDateTime tiempoExtra=LocalDateTime.now().plusSeconds(30);
            while (!transResponse.isSuccessful() && tiempoExtra.isAfter(LocalDateTime.now())) transResponse = clientePlaid.transactionsGet(transRequest).execute();
            
            if (transResponse.isSuccessful()) {
                List<Transaction> transactions = transResponse.body().getTransactions();
                if (transactions != null) {
                    transaciones=transactions.stream().map(e-> new Transaccion(e.getName(), e.getDate(), e.getAmount())).toList();
                    return transaciones;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return transaciones;
        }
        return transaciones;
    }

    
}
