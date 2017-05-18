linguist.py
===========

Work in progress 🔬🔬🔬🔬

Simple Python wrapper around GitHub's [Linguist](https://github.com/github/linguist) (a tool that tells you which programming language a given source code – or an entire git repo – was written in).

### Objective(s)
Being able to run Linguist from Python in a more efficient way instead of spawning subprocesses (+ requiring the library) for each request.

A simple, non very scientific benchmark which runs a single process in the background vs one per request, repeated a thousand times, yields a x2.5 improvement.

### Design
It has a "server" component which is written in Ruby, which imports Linguist and reads requests from STDIN, while sending the results via STDOUT.

The Python "client" spawns the server using `subprocess`' `Popen` and sends requests to it.

### Requirements
* Python 3
* Ruby (tested with 2.3.1, but older versions should work)
  - Linguist gem
