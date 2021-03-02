# Tests

To test the solution, you just **run the test script**. You can do this from Red Console by using function `do` together with test script's path, like this:

```red
do %exercism/red/hello-world/hello-world-test.red
```

Or by just adding it as an argument to the Red binary in your system terminal:

```shell
red exercism/red/hello-world/hello-world-test.red
```

Initially, only the first test from the file will be enabled. This is to encourage you to solve the exercise one step at a time. Once you get the first test passing, change the *value* assigned to `ignore-after` *word* at the beginning of the test script and run it again. This value is a count of enabled tests, so changing it from `1` to `2` will enable second test.
