## Troubleshot

### MDB_MAP_FULL: Environment mapsize limit reached

Sometimes Sorbet can be stuck at "Indexing". This manifests as no type-checking when you hover over any code in the editor ("Loading..."). 

If the output says `sorbet mdb error: what="failed write into database" mdb_error="MDB_MAP_FULL: Environment mapsize limit reached" cache_path="sorbet/.cache"`

You can just blow up the cache by `rm -rf sorbet/.cache`. Restart VSCode and usually it will resolve the issue. 