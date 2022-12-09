# Notes for You Don't Know JS Yet

## Chapter 1

JS is backwords compatible.
It's a good choice for codes living forever.

Consisteny is the most important property for programming language.

## Chpater 2: Surveying JS

### Values

Two kinds of value in JS:

- primitive
  
  - string

    - use `'` or `"` for string literal.
      The choice of `'` or `"` is just a problem of style,
      but bear consisteny in mind.

    - use `` ` `` for interpolation string.
      only use ` for interpolation.

  - boolean

    - `true`

    - `false`

  - number

  - `null` and `undefined`

  it's safest and best to use only `undefined` as the single empty value

  - Symbol

- Object

  - an unordered, keyed collection of any various values.

  - array and function are a special kind of object.

  - two syntaxs of access:
  
    - dot: `.`  only valid identifier

    - square brackets: `[]`  can use expression

use `typeof` to determin a value's type.

``` javascript
typeof 42;                  // "number"
typeof "abc";               // "string"
typeof true;                // "boolean"
typeof undefined;           // "undefined"
typeof null;                // "object" -- oops, bug!
typeof { "a": 1 };          // "object"
typeof [1,2,3];             // "object" not "array"
typeof function hello(){};  // "function" not "object"
```

### Declaring and Using Variables

there are several syntax creating variables:

- `var`

  - global or functional scope

  - optional initial assignment

- `let`

  - block scope

  - optional initial assignment

- `const`

  - block scope

  - required initial assignment

  - cannot be reassigned
    No *reassignment* does not mean no *mutation*.
    You can still mutate a object even it's declared `const`.
    This is where inconsistency happens.
    Only use `const` with primitive values to eliminate this inconsistency.

- `function`

  ``` javascript
  function hello(myName) {
    console.log(`Hello, ${ myName }.`);
  }

  ```

  `hello` is created in the outer scope.
  `myName` is created in the functional scope.
  They both behave like `var`-declared.

- `catch`

  ``` javascript
  try {
    someError();
  }
  catch (err) {
      console.log(err);
  }
  ```

  The `err` is a block-scoped variable that exists only inside the catch clause, as if it had been declared with `let`.

### Functions

There are many syntax forms to make function values.

One thing bear in mind is that function is first class value in JS.

### Comparisons

- incoercive comparison
  `===` tests equality without coercion.
  So unmatched types will directly results `false`
  When comes to object, remember object variable is reference
  there are some inconsistency:
  ``` javascript
    NaN === NaN;            // false
    0 === -0;               // true
  ```
  Therefore, don't use `===` for `NaN` and `-0`
  Use `Number.isNaN` and `Object.is`
  ``` javascript
    Number.isNaN(NaN)     // true
    Object.is(NaN, NaN)   // true
    Object.is(0, -0)      // false
  ```
  
- coercive comparison
  `== > < <= >=`
  other comparison will consider coercion.
  When types unmatch, first coerce.
  use alphabetical comparison for strings.

### How We Organize in JS
