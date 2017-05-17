---
layout: post
categories: [Security]
tags: [RSA, Java]

---

### About RSA


> RSA is an algorithm used by modern computers to encrypt and decrypt messages. 
It is an asymmetric cryptographic algorithm. Asymmetric means that there are two different keys. 
This is also called public key cryptography, because one of them can be given to everyone. 
The other key must be kept private. It is based on the fact that finding the factors of an integer 
is hard (the factoring problem). RSA stands for Ron Rivest, Adi Shamir and Leonard Adleman, 
who first publicly described it in 1978. - wikipedia

When using RSA to sign data, the private key is used to generate a signature of the data;
and the public key will be passed with the data and can be used by anyone to check the content
of the data was not changed.

### Generating key pair

Before we use the RSA algorithm, we need to generate a key pair or load a key pair from a
credential store file.

```
    public static KeyPair generateRSAKeyPair() {
        KeyPairGenerator generator = null;
        try {
            generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(2048, new SecureRandom());
            return generator.generateKeyPair();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return null;
    }
    
    public static final String KEYSTORE_TYPE = "JCEKS";
    
    public static KeyPair loadRSAKeyPair(String keyStoreFilePath, String storePassword, String keyAlias, String keyPassword) {
        if (keyStoreFilePath == null || storePassword == null || keyAlias == null || keyPassword == null) {
            return;
        }

        try {
            InputStream inputStream = new FileInputStream(keyStoreFilePath);
            KeyStore keyStore = KeyStore.getInstance(KEYSTORE_TYPE);
            keyStore.load(inputStream, storePassword.toCharArray());

            KeyStore.PasswordProtection passwordProtection = new KeyStore.PasswordProtection(keyPassword.toCharArray());
            KeyStore.PrivateKeyEntry privateKeyEntry =
                    (KeyStore.PrivateKeyEntry) keyStore.getEntry(keyAlias, passwordProtection);
            Certificate certificate = keyStore.getCertificate(keyAlias);
            PublicKey publicKey = certificate.getPublicKey();
            PrivateKey privateKey = privateKeyEntry.getPrivateKey();
            this.keyPair = new KeyPair(publicKey, privateKey);
        } catch (Exception e) {
            log.error("Failed to load keystore file: " + keyStoreFilePath, e);
        }
    }    
```

### Signing a message and verify the signature

Message signing is commonly used in API design. We can use the signature to check whether the message is tampered or not.
The public key will also be included in the message, so that we can verify the message was sent from a know creator or not.


```
    public static String generateSignature(final String strValue) {
        try {
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.initSign(keyPair.getPrivate());
            signature.update(strValue.getBytes(Constants.STRING_ENCODING));
            return Base64.encodeBase64String(signature.sign());
        } catch (Exception e) {
            log.error("Failed to sign oap token.", e);
        }
        return null;
    }
```

The `SHA256withRSA` algorithm calculates a SHA256 signature of the input and then uses the SHA256 signature to 
calculate the RSA signature (more details in [RFC](https://tools.ietf.org/html/rfc3447#page-32)).

```
    private static boolean verifySignature(String strValue, String rsaSignature, PublicKey pubKey) {
        try {
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.update((strValue.getBytes());
            return signature.verify(Base64.getDecoder().decode(rsaSignature));
        } catch (Exception e) {
            log.error("Failed to verify signature.", e);
        }
        return false;
    }
```

The public key will be encoded (in base64 format) within the message, before we verify the signature, we need to decode the string 
and use the encoded public key to create the PublicKey object as follows:

```
    public static PublicKey getPublicKey(String publicKeyStr) {
        try {
            byte[] byteKey = Base64.getDecoder().decode(publicKeyStr.getBytes());
            X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(byteKey);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            return  keyFactory.generatePublic(x509EncodedKeySpec);
        } catch(Exception e){
           log.error("Failed to create public key.", e);
        }

        return null;
    }
```

To encrypt (use public key) or decrypt (use private key) a message with RSA algorithm, we can use the `Cipher` class
in Java to get a `RSA` instance, and use the ENCRYPT_MODE or DECRYPT_MODE to encrypt
or decrypt the message.