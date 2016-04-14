# -*- coding: utf-8 -*-
"""
    python_essential_reference.page305
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Weakref.

    :copyright: (c) 2016 by Rambler&Co.
"""

import sys
import weakref


class A(object):
    pass


if __name__ == '__main__':
    a = A()
    print(sys.getrefcount(a))
    awref = weakref.ref(a)
    print(sys.getrefcount(a))
    aref = a
    print(sys.getrefcount(a))

    print(awref)
    print(awref())
    print(a)
    print(a is awref())
    print(a == awref())
