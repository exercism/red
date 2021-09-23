# Exercism Red Track

[![configlet](https://github.com/exercism/red/workflows/configlet/badge.svg)](https://github.com/exercism/red/actions?query=workflow%3Aconfiglet)

Exercism exercises in [Red](https://www.red-lang.org/).

Tooling:

* [Test Runner](https://github.com/exercism/red-test-runner)
* [Analyzer](https://github.com/exercism/red-analyzer) (not ready)
* [Representer](https://github.com/exercism/red-representer) (not ready)

## Contributing

Please see the [old contributing guide](https://github.com/exercism/legacy-docs/tree/master/contributing-to-language-tracks) and [new track building guide](https://github.com/exercism/docs/tree/main/building/tracks). This track is currently at the beginning of it's creation, so any help is very welcome.

Worth checking are also excellent [general](https://hackmd.io/60gYIZYYS-6_l8kLH0QXAQ?view) and [concepts](https://github.com/exercism/elm/blob/main/docs/contributing-concept.md) guides from Elm track maintainers, that are in great part universal and can be applied also to Red track.

### Exercise ideas

Generally, [practice exercises](https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md) are best taken from [Exercism's problem-specifications repository](https://github.com/exercism/problem-specifications), so the experience is similar for students in every language track. But in case you need some fresh ideas, here are some links with script examples you can check for inspiration:

* http://www.mycode4fun.co.uk/red-beginners-reference-guide
* http://redprogramming.com/Short%20Red%20Code%20Examples.html#section-2
* https://github.com/red/red/wiki/%5BLINKS%5D-Scripts-collection

Scripts in Rebol (it's very similar to Red)

* http://www.rebol.org/script-index.r
* http://reb4.me/r/
* http://www.rebol.com/oneliners.html

### Concepts

Useful for [concepts](https://github.com/exercism/docs/blob/main/building/tracks/concepts.md) and [concept exercises](https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md)

* http://helpin.red/

Concepts are being developed in separate branch. More info in GitHub task: https://github.com/exercism/red/issues/37 . There is no common source or list for concepts. Existing ones were created simply from looking at practice exercises example solutions and deducting what's needed to create and understand it.

There is a tool, that counts and prints exercises unlocked by each concept, and exercises that practice the concept:

`_tools/concepts-practice.red`

Recently, Exercism introduced tasks, which are just parts of an exercise. Currently, they are only possible in concept exercises. You can indicate, which tests are specific for particular task. Each track links tasks with tests [in a way maintainers find appropriate](https://github.com/exercism/docs/blob/main/building/tooling/test-runners/interface.md#task-id). In Red it is done by adding `"   task_id: 1"` at the end of the test description string in exercise test file. Notice three spaces before "task_id".

## Contact

Besides creating issues and commenting in this repository, you are welcome to post on [Red's "training" Gitter channel](https://gitter.im/red/training).
