# Installation

In a simplest case, you don't install Red. You just download it and it's ready to go.

1. Download page: [https://www.red-lang.org/p/download.html](https://www.red-lang.org/p/download.html) . Files are named with date of build and a Git hash, for example: `red-02mar21-6de9b93c5.exe`. If your anti-virus program detects a virus in Red, don't be scared. [It's normal](https://github.com/red/red/wiki/[NOTE]-Anti-virus-false-positives). Just allow for download and mark Red as safe program in anti-virus' options to calm it down.

1. Save it anywhere you want and run it. [REPL console](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) opens and **you can begin typing Red commands** and immediately see results. If you want to run script, you just use command "[do](https://www.red-by-example.org/#do)": `do %my-dir/my-script.red` (percent sign is important, it marks [Red's `file!` datatype](https://github.com/red/docs/blob/master/en/datatypes/file.adoc)). If you downloaded GUI version, instead of text console, a nice window will be opened, and you can write commands there as well.

1. Another way you can run scripts is not using console (graphical or text), but instead just passing their names as arguments to Red **in commandline**, like: `red.exe my-dir\my-script.red`.

1. It's always good to **rename** downloaded file to `red.exe` (or `red` on Linux/Mac) and **add it to your system's *PATH* environment variable**, so you can run it from every folder and don't have to remember full name of downloaded automated build file. Also, it makes easier to update Red configured this way.

1. Under **Linux**, Red needs 32-bit version of *Curl* (and *Gtk 3* if you use GUI). There is an [AUR package](https://aur.archlinux.org/packages/red-nightly-bin) for Arch / Manjaro Linux.

1. If you are using **macOS**, [you cannot run 32-bit applicatons](https://support.apple.com/en-us/HT208436), and therefore, Red.
