# Introduction

Everything you need to run Red programs and do exercises in Exercism:

* Using editor
* Running your code
* Executing tests for exercises

Red code is built from **blocks** and **values**. Block can contain values and other blocks. In fact, a block is also a value.

Each value has its **type**. Block's type is `block!`. And type is also a value of type `type!`. There are lots of types in Red, like numbers, dates, tuples, urls, paths, strings, binary data, maps, vectors, emails... about a 50 of them.

There are also **comments**. They start with `;` and end with end of line. Red has also block comments, but they are a different kind. In fact, they are accomplished with a function called `comment`, which takes any type of argument (can be block, string or anything) and just does absolutely nothing.

Red is a homoiconic language, so it's code is actually just a data, until we **evaluate** a block. Which simply means, that we "execute" it and get value of last expression.


