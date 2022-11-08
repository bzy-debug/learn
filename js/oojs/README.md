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
