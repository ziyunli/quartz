---
title: "Mojo"
date: 2023-07-16
---
My mental model for Mojo right now is "Typed Python", similar to TypeScript to JavaScript. 
However, even though Mojo uses all of Python's syntax and semantics, but it's not a superset of Python.

Some basic conversions from Python:
1. `def` → `fn`
2. Variables: `var` for mutable, `let` for immutable

Like Rust, Mojo has the concept of ownership, but with different syntax and semantics. 

It also seems to only apply to function arguments:
1. `borrowed` by default **immutable references**
2. `inout` mutable, i.e. changes are visible *outside* the function
3. `owned` mutable and guaranteed unique
	1. By default, ==this makes a copy== of the data
	2. use `^` to "transfer", i.e. `set_fire(a^)`

Mojo always makes a copy for returned value. 

A `struct` is like `class` that
- supports:
	- fields,
	- methods, 
	- operator overloading
	- decorators
- but:
	- bound at compile time
	- no dynamic dispatch
	- no runtime change