# Exercism Red Track

[![Configlet](https://github.com/exercism/red/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/red/actions/workflows/configlet.yml) [![Test](https://github.com/exercism/red/actions/workflows/ci.yml/badge.svg)](https://github.com/exercism/red/actions/workflows/ci.yml)

Exercises and a course in [Red](https://www.red-lang.org/).

Tooling:

* [Test Runner](https://github.com/exercism/red-test-runner)
* [Analyzer](https://github.com/exercism/red-analyzer) (not ready)
* [Representer](https://github.com/exercism/red-representer) (not ready)

## Contributing

Please, see the official contributing guide's [Building Tracks](https://exercism.org/docs/building/tracks) section. This track is already published, but there are many things to improve:

* We want to [complete basic concepts](https://github.com/exercism/red/issues/37).
* You also can always add a new practice exercise.
* Walk through the track, proofread any docs, [report problems](https://github.com/exercism/red/issues/new), or just [give us](https://github.com/exercism/red/issues/new) any suggestions and thoughts you have on your mind.

There is also some interesting general info about Exercism, but remember it's a legacy documentation and can be outdated and [official docs](https://exercism.org/docs) always take precedence:

* [Overview of Exercism](https://github.com/exercism/legacy-docs/blob/main/about/README.md)
* [The Goal of Exercism](https://github.com/exercism/legacy-docs/blob/main/about/goal-of-exercism.md)
* [The scope of a track](https://github.com/exercism/legacy-docs/blob/main/about/scope-of-a-track.md)

### Exercise ideas

Generally, [practice exercises](https://exercism.org/docs/building/tracks/practice-exercises) are best taken from [Exercism's problem-specifications repository](https://github.com/exercism/problem-specifications), so the experience is similar for students in every language track. But in case you need some fresh ideas, here are some links with script examples you can check for inspiration, especially in topics specific to Red:

* http://www.mycode4fun.co.uk/red-beginners-reference-guide
* http://redprogramming.com/Short%20Red%20Code%20Examples.html#section-2
* https://github.com/red/red/wiki/%5BLINKS%5D-Scripts-collection

Scripts in Rebol (it's very similar to Red)

* http://www.rebol.org/script-index.r
* http://reb4.me/r/
* http://www.rebol.com/oneliners.html

### Practice exercises

First, read [official documentation](https://exercism.org/docs/building/tracks/practice-exercises) for background.

Now, here's how we do this in the Red track:

1. [Create an issue](https://github.com/exercism/red/issues/new) to let everybody know which exercises are being worked on,
2. Clone this repo,
3. Run our exercise generator; it will create all necessary files for the exercise:
```shell
$ red _tools/generate-practice-exercise.red <exercise-slug>
```
4. In `exercises/practice/<exercise-slug>/<exercise-slug>-test.red` make a change like this, to test your example solution:
```red
; test-init/limit %exercise-slug.red 1
test-init/limit %.meta/example.red 1
```
5. Solve the exercise example, by editing `exercises/practice/<exercise-slug>/.meta/example.red`,
6. Run the tests. You'll need to change the second argument of the `test-init` function from `1` to how many tests you want to run in `<exercise-slug>-test.red`.
```shell
$ cd exercises/practice/<exercise-slug>
$ red <exercise-slug>-test.red
```
7. Once your solution passes all the tests, remember to revert the changes made ↑ at *point 4* in the `test-init` line: uncomment solution file, comment example file and change `limit` to `1` (second argument).
8. Change the exercise's difficulty in track's `config,json`. If you want, add `practices` and `prerequisites` concepts. Copy the exercise's config to the proper position, so that all exercises are sorted from easiest to toughest.
9. Make a commit to a fresh branch and [make a Pull Request](https://exercism.org/docs/building/github/contributors-pull-request-guide).

### Concepts

Useful for [concepts](https://github.com/exercism/docs/blob/main/building/tracks/concepts.md) and [concept exercises](https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md)

* http://helpin.red/

Concepts are being developed in a separate branch. More info is in GitHub task: https://github.com/exercism/red/issues/37 . There is no common source or list for concepts. Existing ones were created simply from looking at the practice exercises' example solutions and deducing what's needed to create and understand them.

There is a tool that counts and prints exercises unlocked by each concept, and exercises that practice the concept:

`_tools/concepts-practice.red`

Recently, Exercism introduced tasks, which are just parts of an exercise. Currently, they are only possible in concept exercises. You can indicate, which tests are specific for particular task. Each track links tasks with tests [in a way maintainers find appropriate](https://github.com/exercism/docs/blob/main/building/tooling/test-runners/interface.md#task-id). In Red it is done by adding `"   task_id: 1"` at the end of the test description string in exercise test file. Notice three spaces before "task_id".

## Contact

Besides creating issues and commenting in this repository, you are welcome to post on [Red's "training" Gitter channel](https://gitter.im/red/training).
