package com.ice.util;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.xml.bind.DatatypeConverter;

/**
 * Hashing functions for passwords.
 * This class also provides functions to convert the byte array returned to a hex value of the byte array and vice versa.
 * @author Kelvin
 *
 */
public class HashingUtil {
	public static String byteArrayToHex(byte[] array) {
		return DatatypeConverter.printHexBinary(array);
	}
	
	public static byte[] hexToByteArray(String hex) {
		return DatatypeConverter.parseHexBinary(hex);
	}
	
    /**
     * Hashes a password with PBKDF2. Salt is required to hash the password.
     *
     * @param password The password to hash
     * @param salt The salt to make it random
     * @param iterations Amount of rounds to run the algorithm
     * @param keyLength The length of the key it will generate
     * @return The hashed password from the algorithm.
     */
    public static byte[] hashPassword(final char[] password, final byte[] salt, final int iterations, final int keyLength) {

        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
            PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, keyLength);
            SecretKey key = skf.generateSecret(spec);
            byte[] res = key.getEncoded();
            return res;

        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }
}
