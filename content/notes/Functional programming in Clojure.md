---
title: "Functional programming in Clojure"
date: 2022-11-07
---

link:: https://iloveponies.github.io/120-hour-epic-sax-marathon/index.html

# Basic Tools

```sh
brew install leiningen
```

Commands:
- `midje`: run all [Midje](https://github.com/marick/Midje) tests
	- `lein midje :autotest`: this starts a loop which runs the tests again every time you make changes to any of the projects files.
- `repl`
- `new`: create a new Clojure project
- `cljfmt check` and `cljfmt fix`: code formatting with [cljfmt](https://github.com/weavejester/cljfmt)

Using [Calva](https://calva.io/) with VS Code. Follow instructions in [Calva and the VIM Extension
](https://calva.io/vim/) to avoid issues in the editor. 

# Training day

## Prefix Syntax

All function calls in Clojure look the same: `(function-name argument-1 argument-2 ...)`.

## Functions

The functions created with `fn` are called _anonymous functions_. 
```clojure
(fn [name] (str "Welcome to Rivendell mr " name))
```

To give a name to a function we can use `def`.
```clojure
(def hello (fn [who] (str "Hello, " who "!")))
```

To make that a bit easier, we have `defn` to create _and_ name a function
```clojure
(defn                                 ; Start a function definition:
  hello                               ; name
  "Gives out personalized greetings." ; a optional docstring
  [who]                               ; parameters inside brackets
  (str "Hello, " who "!"))            ; body
```

## Namespaces

If a namespace name has an hyphen, the corresponding file name should have an underscore, e.g. for `training_day.clj`
```clojure
(ns training-day)
```

To call a function in REPL. The `'` before the namespace name in a `use` is **important**.
```clojure
(use 'training-day)
hai
```

## Misc

`\o` in Clojure code means the single character `o`

`str` is a function that turns its argument to a string. If given multiple arguments, it concatenates the results:
```clojure
(str "Over " 9000 "!") ;=> "Over 9000!"
```

To take a look at the docstring in REPL
```clojure
user=> (use 'clojure.repl)
user=> (doc +)
-------------------------
clojure.core/+
([] [x] [x y] [x y & more])
  Returns the sum of nums. (+) returns 0. Does not auto-promote
  longs, will throw on overflow. See also: +'
nil
```

```clojure
user=> (user/clojuredocs min)
========== vvv Examples ================
  user=> (min 1 2 3 4 5)  
  1
  user=> (min 5 4 3 2 1)
  1
  user=> (min 100)
  100
========== ^^^ Examples ================
1 example found for clojure.core/min
nil
```

# I am a horse in the land of booleans

In functional programming, and specifically in Clojure, everything is an expression. This is a way of saying that everything has a usable value. Concretely, `if` has a return value; the value is the value of the evaluated body (either the _then_ or the _else_ body).

There is no need for a `return` clause – there is no such keyword in Clojure – because the return value of a function is always the value of the last expression in the body of the function.

## If then else

`if` (usually) takes three parameters: the conditional clause, the _then_ body and the _else_ body. If the first parameter - the conditional clause - is true, the _then_ body is evaluated. Otherwise, the _else_ body is evaluated.

```clojure
(if (my-father? darth-vader)  ; Conditional
  (lose-hand me)              ; If true
  (gain-hat me))              ; If false
```

## Comparing values

Values can be compared for equality with `=`

```clojure
(= "foo" "foo")    ;=> true
(= "foo" "bar")    ;=> false
```

Numerical values should be compared with `==`

```clojure
(== 42  42) ;=> true
(== 5.0  5) ;=> true
(=  5.0  5) ;=> false !
```

`==` disregards the actual type of the numeric value, whereas `=` requires that the numbers are of the same type.

All the comparison functions above take an arbitrary amount of arguments.

```clojure
(= x y z) ;=> true if and only if x = y = z
(< x y z q) ;=> true if and only if x < y < z < q
```

## Conditioning

```clojure
(cond
  condition1 true1
  condition2 true2
  condition3 true3
  ...)
```

## Boolean functions

Clojure has two boolean values: `true` and `false`. However, all values can be used in a boolean context like `if`. Everything except `nil` and `false` acts as `true`.

```clojure
(if "foo" "truthy" "falsey") ;=> "truthy"
(if 0     "truthy" "falsey") ;=> "truthy"
(if []    "truthy" "falsey") ;=> "truthy"
(if false "truthy" "falsey") ;=> "falsey"
(if nil   "truthy" "falsey") ;=> "falsey"
```


The common boolean functions in Clojure are `and`, `or` and `not`.

`and` and `or` take an arbitrary amount of arguments.

In addition to booleans, `and`, `or` and `not` accept non-boolean values as arguments as well.

`and` returns truthy if all of its arguments are truthy:

```clojure
(and "foo" "bar")   ;=> "bar"
(and "foo"  false)  ;=> false
(and  10    nil)    ;=> nil
```

What’s happening is that if all the arguments to `and` are truthy, it returns the value of the last argument. Otherwise, it returns the value of the first falsey argument.

`or` returns truthy if any of its arguments is truthy:

```clojure
(or  "foo"  false)  ;=> "foo"
(or   42    true)   ;=> 42
```

Conversely, `or` returns either the first truthy value or the last falsey value.

`not` returns `true` if its argument is falsey and `false` if its argument is truthy:

```clojure
(not "foo")         ;=> false
(not nil)           ;=> true
(not [])            ;=> false
```

-   `(number? n)` returns `true` if `n` is a number.
-   `(empty? coll)` returns `true` if `coll` is empty.
-   `(list? coll)` and `(vector? coll)` test if `coll` is a list or a vector.
-   `(count coll)` returns the length of a list or a vector.

# Structured data

