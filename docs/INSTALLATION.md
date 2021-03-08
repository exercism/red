# Installation

In general, you don't install Red. You download it and it's ready to go.

1. Download page: https://www.red-lang.org/p/download.html . **Important**: Stable build is VERY OUTDATED, so the best you can do is to download from *Automated builds* section. Files are named with date of build and a Git hash, for example: `red-02mar21-6de9b93c5.exe`. If your anti-virus program detects a virus in Red, don't be scared. [It's normal](https://github.com/red/red/wiki/[NOTE]-Anti-virus-false-positives). Just allow for download and mark Red as safe program in anti-virus' options to calm it down.

1. Save it anywhere and run it. At first run, it compiles a [REPL console](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) program and saves it in user's system directory, so you have to wait few minutes. Second time it's almost instant. Console opens and **you can begin typing Red commands** and immediately see results. If you want to run script, you just use command "do": `do %my-dir/my-script.red` (percent sign is important, it marks Red's `file!` datatype).

1. Another way you can run scripts is not using REPL Console, but just giving them as arguments to Red **in commandline**: `red.exe my-dir\my-script.red`.

1. It's always good to **rename** downloaded file to `red.exe` (or `red` on Linux/Mac) and **add it to your system's *PATH* environment variable**, so you can run it from every folder and don't have to remember full name of downloaded automated build file. Also, it makes easier to update Red configured this way.
