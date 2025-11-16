---
title: Digital Signature
tags:
  - Cryptography
---

To create a digital signature scheme, you essentially need three functions:

Generate Keys `publicKey, privateKey = GenerateKeys()`

- It returns a pair of keys - public key: your identity
  - secret key (sometimes called private key): your secret  
    It doesn't take any arguments but just randomness (It has to be _long enough_)

Sign `signature = Sign(privateKey, message)`

- It takes your secret key and your message
- It returns a signature

Verify `isValid = Verify(publicKey, message, signature)`

- It takes a public key, a message and a signature
- It returns a boolean
