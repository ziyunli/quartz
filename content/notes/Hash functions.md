---
title: Hash functions
---
- Primitives for making a cryptocurrency
- `hash(data) -> output`
  * Data can be any size
  * Output is fixed size and "random" looking (half the bits are 1s, half are 0s)
      * The avalanche effect: changing a single bit in the input should change _about half of the bits_ of the output
  * Sha-256: the output size is 32 bytes long, or 256 bits long.
- Definitions
  * Pre-image resistance: given y, you can't find any x such that `hash(x) == y`  
      * You can if you brute force, which takes 2^256 operations (10^78)  
  * Second pre-image resistance: given x, y, such that `hash(x) == y`, you can't find x' where `x' != x` and `hash(x') == y`  
  * Collision resistance: no body can find any x, z such that `x != z` and `hash(x) == hash(z)`  
      * again, you can find them eventually, and in this case *not* 2^256 but 2^128.  
  	    * Just start trying things and keeping track of all their hashes  
  	    * "birthday attack": as you keep trying them, there's more possibilities.  
      * "harder": collision resistance can be broken while pre-image resistance remains (sha-1, md5)
- Usages
  * names
  * references
  * pointers
  * commitments
      * content + randomness (HMAC: hash-based message authentication code)