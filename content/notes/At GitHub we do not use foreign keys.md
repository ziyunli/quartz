---
title: "At GitHub we do not use foreign keys"
date: 2023-07-05
---

From https://github.com/github/gh-ost/issues/331#issuecomment-266027731

Main reasons are:
- FKs are in your way to shard your database. Your app is accustomed to rely on FK to maintain integrity, instead of doing it on its own. It may even rely on FK to cascade deletes (shudder). When eventually you want to shard or extract data out, you need to change & test the app to an unknown extent.
- FKs are a performance impact. The fact they require indexes is likely fine, since those indexes are needed anyhow. But the lookup made for each insert/delete is an overhead.
- FKs don't work well with online schema migrations.