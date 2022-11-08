Should not use arrow syntax in object function. For example:

```javascript
const person = {
  name: ["Bob", "Smith"],
  age: 32,
  bio() {
    console.log(`${this.name[0]} ${this.name[1]} is ${this.age} years old.`)
  },
  introduceSelf() {
    console.log(`Hi, I'm ${this.name[0]}`)
  }
}
```

above is not the same as the following.

```javascript
const person = {
  name: ["Bob", "Smith"],
  age: 32,
  bio: () => {
    console.log(`${this.name[0]} ${this.name[1]} is ${this.age} years old.`)
  },
  introduceSelf: () => {
    console.log(`Hi, I'm ${this.name[0]}`)
  }
}
```

Because arrow syntax won't bind `this` to `person`.
According to [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions),

Arrow function don't have their own bindings to `this`

Dot notation can only accept a literal member name, while bracket notation can accept variable.

When you call constructor with `new`, it will do four things:

- create a new object
- bind `this` to the new object, so you can refer to `this` in your constructor code
- run the code in the constructor
- return the new object.

like this:
```javascript
function person(name) {
  let newObj = {}
  this = newObj
  // run code
  return this
}
```
