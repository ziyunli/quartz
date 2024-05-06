---
title: "Learning Rust"
date: 2023-07-18
---

## Cargo 

- `cargo clippy`: https://doc.rust-lang.org/clippy/usage.html 
	- `#![warn(clippy::all, clippy::pedantic)]`
- `cargo add`: https://doc.rust-lang.org/cargo/commands/cargo-add.html
- `cargo search`: https://doc.rust-lang.org/cargo/commands/cargo-search.html

## Ownership

> [!cite] https://google.github.io/comprehensive-rust/ownership/copy-clone.html
> copying and cloning are not the same thing: 
> - Copying refers to bitwise copies of memory regions and does not work on arbitrary objects. 
> - Copying does not allow for custom logic (unlike copy constructors in C++). 
> - Cloning is a more general operation and also allows for custom behavior by implementing the Clone trait. 
> - Copying does not work on types that implement the Drop trait.

The `Copy` trait in Rust is used for types that can be shallowly copied by simply copying their bits in memory.

```rust
#[derive(Debug, Copy, Clone)]
struct SimpleStruct {
    a: i32,
    b: i32,
}

fn main() {
    let x = SimpleStruct { a: 1, b: 2 };
    let y = x;  // Copy happens here.
    println!("{:?}", x);  // x is still valid and its value is unchanged.
}
```

The `Clone` trait is used for types that need custom behavior when creating a full copy of an object.

```rust
#[derive(Debug, Clone)]
struct ComplexStruct {
    a: i32,
    v: Vec<i32>,
}

fn main() {
    let x = ComplexStruct { a: 1, v: vec![1, 2, 3] };
    let y = x.clone();  // Clone happens here.
    println!("{:?}", x);  // x is still valid and its value is unchanged.
}
```

**Copy does not work on types that implement the `Drop` trait**. The `Drop` trait provides a destructor that is called when an object goes out of scope, and it implies that the object has some resource that needs to be cleaned up when it's dropped. Copying such an object could lead to the resource being cleaned up twice, which is usually a bug.
