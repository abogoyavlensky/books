# -*- coding: utf-8 -*-
"""
    python_essential_reference.page339
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Contextlib module. Closing context manager.

    :copyright: (c) 2016 by Rambler&Co.
"""
from contextlib import closing


if __name__ == '__main__':
    f = open('page40.txt')
    print(f.closed)
    with closing(f) as opened_file:
        for line in f:
            print line

    print(f.closed)
