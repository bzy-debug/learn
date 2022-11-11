# What I learnt from this project

- `label` is used to associate input with text.
  With label, when user clicks the text, it's like that he/she clicks the input

- `input` is a **self-closing** element.

- `label`'s `for` and `input`'s `id` should have the same value, which describes the meaning of input.

- `value` of `input` is the text showed to user.

- `required` of `input` can prevent user from submitting from if he/she does not fill the input

- `minlength` of `input`

- `pattern` of `input` makes sure the input should match the regexp

- To relate the `radio` inputs, give them the same `name` attribute

- the types of `input`: `text`, `radio`, `checkbox`, `file`, `number`

- `textarea` input is the multi-line input.

- `textarea` attributes: `rows`, `cols`, `placeholder`

- `min` and `max` are for `number`

- `select` and `option` element

- `value` attribute is the value sent to the server

- `p:last-of-type{}` will select the last `p` element

- To style the submit button, you can use an attribute selector,
which selects an element based on the given attribute value. Here is an example:
`input[name="password"]`
