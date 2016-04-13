# -*- coding: utf-8 -*-
"""
    python_essential_reference.page249
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Timeit.

    :copyright: (c) 2016 by Rambler&Co.
"""

from timeit import repeat, timeit


if __name__ == '__main__':
    print(repeat('math.sqrt(2.0)', 'import math'))
    first = timeit('math.sqrt(2.0)', 'import math')
    second = timeit('sqrt(2.0)', 'from math import sqrt')
    increase = first / second
    print(first)
    print(second)
    print('Speed increase: {:0.2f}'.format(increase))
