---
title: "Let's Go"
date: 2023-07-19
---

## Go Project Basics

In the Go community, a common convention is to base your module paths on a URL that you own. 

```bash
go mod init snippetbox.alexedwards.net
go mod init github.com/ziyunli/snippetbox
```

You can run by the full module path, for example
```shell
go run github.com/ziyunli/snippetbox
```

Web application essentials in Go
1. `handler`: like *controller* in MVC
2. `servermux`: *router* that maps URL patterns to handlers
3. `web server`

### Project Structure

The project structure follows a popular template in the Go community, https://github.com/thockin/go-build-template. 

`cmd` for executable applications

`internal` for non-application-specific code. The `go build` tool treats these `internal packages` specially. 

> An internal package may be imported only by another package that is inside the tree rooted at the parent of the internal directory.[^1]

`ui` for *user-interface assets*

## `servermux`

`servermux` supports two types of URL patterns:
1. *fixed paths*: do *not* end with a trailing slash; only matched when the request URL path **exactly** matches the fixed path. 
2. *subtree paths*: matched whenever the *start* of a request URL path matches the subtree path. 

The longer URL patterns always take precedence over shorter ones. You can register patterns in any order *and it won't change how the servemux behaves*. 

Request URL paths are sanitized, meaning `.`, `..`, repeated `/`s will be converted to a *301 Permanent Redirect*. 

It does *not* support:
1. routing based on the request HTTP method
2. clean URLs with variables 
3. regex-based patterns

[^1]: https://www.gopl.io/ "The Go Programming Language"