package org.taulyd.seguridad;

import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;

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

    public static void main(String[] args) {
        KeyPairGenerator gen;
        try {
            gen = KeyPairGenerator.getInstance("EC");
            gen.initialize(256); // P-256
            KeyPair keyPair = gen.generateKeyPair();

            PrivateKey privateKey = keyPair.getPrivate();
            PublicKey publicKey = keyPair.getPublic();
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
