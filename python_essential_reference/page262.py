# -*- coding: utf-8 -*-
"""
    python_essential_reference.page262
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Compile, exec, eval.

    :copyright: (c) 2016 by Rambler&Co.
"""


if __name__ == '__main__':
    c = compile('import math;print(math.sqrt(2.0))', 'page249.py', 'exec')
    print(type(c))
    eval(c)

    results = eval('(x + 3) * y', {'y': 2}, {'x': 10})
    print(results)

    exec c
