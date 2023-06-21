# Debug

All output from your Red script is visible in console, when running every test. You can `print` what you want, for example words' values:

```red
print ["x =" x]
```

Also, `probe` function is very useful. When evaluated, it evaluates its input, prints the result in a way that reflects its type, and returns it. So it's in most cases "transparent", and you can insert it inside expressions:

```red
x: 10
y: probe x + 5
```

Sometimes function called `type?` (yes, it has question mark in its name!) can be useful to check value's type:

```red
print ["x type:" type? x]
```

There are also some more advanced debugging techniques [listed on Red's Wiki](https://github.com/red/red/wiki/%5BDOC%5D-Debugging).
