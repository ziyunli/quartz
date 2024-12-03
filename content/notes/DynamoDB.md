> While it’s true that DynamoDB won’t _enforce_ a schema to the extent that a relational database will, you will still need a schema somewhere in your application. Rather than validating your data at the database level, it will now be an application-level concern.

Explicit (enforced on write) v.s. Implicit (handled on read).

Key properties:
1. Data model
	1. KV
	2. Wide-column: B-tree that allows you to quickly find a particular item in the data structure while also allowing for range queries.
2. Why
	1. Performance: in terms of response time (single-digit ms)
	2. Scale: size > 100TB without performance degradation
3. HTTP model instead of connection pool
4. Best for
	1. hyper-scale applications, which means relaxing
		1. join functionality
		2. strong consistency
	2. hyper-ephemeral compute
	3. OLTP applications where end users are reading and writing small bits of data at high speeds
	4. caching
	5. simple data model that doesn’t require complex querying

> A Read Capacity Unit gives you a single strongly-consistent read per second or two eventually-consistent reads per second, up to 4KB in size. A Write Capacity Unit allows you to write a single item per second, up to 1KB in size.


Concepts