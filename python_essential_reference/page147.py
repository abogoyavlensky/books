# -*- coding: utf-8 -*-
"""
    python_essential_reference.page147
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Coroutines.

    :copyright: (c) 2016 by Rambler&Co.
"""

import bz2
import fnmatch
import gzip
import os

import sys


def coro(func):

    def start(*args, **kwargs):
        f = func(*args, **kwargs)
        f.next()
        return f

    return start


@coro
def find_files(target):
    while True:
        topdir, pattern = (yield)
        for path, dirname, filelist in os.walk(topdir):
            for name in filelist:
                if fnmatch.fnmatch(name, pattern):
                    target.send(os.path.join(path, name))


@coro
def opener(target):
    while True:
        name = (yield)
        if name.endswith('.gz'):
            f = gzip.open(name)
        elif name.endswith('.bz2'):
            f = bz2.BZ2File(name)
        else:
            f = open(name)
        target.send(f)


@coro
def cat(target):
    while True:
        f = (yield)
        for line in f:
            target.send(line)


@coro
def grep(pattern, target):
    while True:
        line = (yield)
        if pattern in line:
            target.send(line)


@coro
def printer():
    while True:
        line = (yield)
        sys.stdout.write(line)


if __name__ == '__main__' and __package__ is None:
    finder = find_files(opener(cat(grep('python', printer()))))

    # Теперь передать значение
    print(finder.send(('www', 'access - log *')))
    print(finder.send(('otherwww', 'access - log *')))
