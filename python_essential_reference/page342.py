# -*- coding: utf-8 -*-
"""
    python_essential_reference.page342
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Heapq module. Merge sorted sequence.

    :copyright: (c) 2016 by Rambler&Co.
"""
from heapq import merge

if __name__ == '__main__':

    l1 = [10, 20, 30, 40]
    l2 = [8, 15, 27, 33, 55]

    print(list(merge(l1, l2)))
