# -*- coding: utf-8 -*-
"""
    python_essential_reference.pipelines
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    A powerful functional programming technique is the use of pipelines
    of functions.
    http://code.activestate.com/recipes/580625-collection-pipeline-in-python/?
    in=lang-python

    :copyright: (c) 2016 by Rambler&Co.
"""
from operator import mul


class Map:
    def __init__(self, func):
        self.func = func

    def __ror__(self, iterable):
        for obj in iterable:
            yield self.func(obj)


class Filter:
    def __init__(self, func):
        self.func = func

    def __ror__(self, iterable):
        for obj in iterable:
            if self.func(obj):
                yield obj


_SENTINEL = object()


class Reduce:
    def __init__(self, func, start=_SENTINEL):
        self.func = func
        self.start = start

    def __ror__(self, iterable):
        it = iter(iterable)
        func = self.func
        result = self.start
        if result is _SENTINEL:
            result = next(it, _SENTINEL)
            if result is _SENTINEL:
                raise ValueError('empty iterable')
        for obj in it:
            result = func(result, obj)
        return result


class Apply:
    def __init__(self, func):
        self.func = func

    def __ror__(self, iterable):
        return self.func(iterable)


List = Apply(list)


if __name__ == '__main__':
    Reverse = Apply(reversed)
    results = 'absd' | Reverse | List
    print(results)

    results = "abcd12345xyz" | Filter(str.isdigit) | Map(int) | Reduce(mul)
    print(results)
