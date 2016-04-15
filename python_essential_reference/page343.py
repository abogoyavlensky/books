# -*- coding: utf-8 -*-
"""
    python_essential_reference.page343
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Itertools examples.

    :copyright: (c) 2016 by Rambler&Co.
"""
from itertools import combinations, count

if __name__ == '__main__':
    result = combinations([1, 2, 3, 4], 2)
    print(list(result))

    c = count(0)
    i = c.next()
    while i < 10:
        print(i)
        i = c.next()
