# -*- coding: utf-8 -*-
"""
    python_essential_reference.page559
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Coroutines example.

    :copyright: (c) 2016 by Rambler&Co.
"""
import inspect
from collections import deque


def foo():
    for i in xrange(5):
        print('{} - {}'.format(inspect.stack()[0][3], i))
        yield


def bar():
    for i in xrange(10):
        print('{} - {}'.format(inspect.stack()[0][3], i))
        yield


def spam():
    for i in xrange(7):
        print('{} - {}'.format(inspect.stack()[0][3], i))
        yield


if __name__ == '__main__':
    q = deque()
    q.append(foo())
    q.append(bar())
    q.append(spam())

    while q:
        task = q.pop()
        try:
            next(task)
        except StopIteration:
            print('Task {} has been finished.'.format(task.__name__))
        else:
            q.appendleft(task)
