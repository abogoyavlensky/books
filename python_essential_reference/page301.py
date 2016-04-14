# -*- coding: utf-8 -*-
"""
    python_essential_reference.page301
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Traceback module.

    :copyright: (c) 2016 by Rambler&Co.
"""

import traceback


if __name__ == '__main__':
    empty_list = []
    try:
        empty_list[0]
    except LookupError as e:
        print(traceback.format_exc())
