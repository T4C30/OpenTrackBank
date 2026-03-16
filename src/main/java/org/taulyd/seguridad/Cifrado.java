package org.taulyd.seguridad;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

public class Cifrado {
    public static String sha256(String texto) {
        try {
            // 1. Obtener instancia de SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            
            // 2. Aplicar hash a la entrada (bytes)
            byte[] encodedhash = digest.digest(texto.getBytes(StandardCharsets.UTF_8));
            
            // 3. Convertir bytes a hexadecimal
            StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
            
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return "";
        }
    }



    public static KeyPair generadorClave(){
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(2048);  // Tamaño de la clave
            return keyPairGenerator.generateKeyPair();
        } catch (NoSuchAlgorithmException e) {
            System.err.println(e.getMessage());
            return null;
        }
    }


    public static boolean comprobacionClaves(PrivateKey clavePrivada, PublicKey clavePublica){
        try {
            Signature certificado = Signature.getInstance("SHA256withRSA");
            certificado.initSign(clavePrivada);
            byte[] firma = certificado.sign();

            certificado.initVerify(clavePublica);

            return certificado.verify(firma);
        } catch (NoSuchAlgorithmException | InvalidKeyException | SignatureException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }


    
    public static PublicKey generatePublicKeyFromPrivate(PrivateKey privateKey) {
        try {
            // Usamos el KeyFactory para obtener las especificaciones de la clave privada
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            
            // Convierte la clave privada en un objeto RSAPrivateKey
            RSAPrivateKey rsaPrivateKey = (RSAPrivateKey) privateKey;
            
            
            
            // Generamos el objeto RSAPublicKeySpec a partir de la información de la clave privada
            RSAPublicKeySpec publicKeySpec = new RSAPublicKeySpec(rsaPrivateKey.getModulus(), BigInteger.valueOf(65537));
            
            // Ahora generamos la clave pública a partir de las especificaciones
            return keyFactory.generatePublic(publicKeySpec);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            ex.printStackTrace();
            return null;
        }
    }
 
}
