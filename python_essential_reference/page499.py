# -*- coding: utf-8 -*-
"""
    python_essential_reference.page499
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Split file name.

    :copyright: (c) 2016 by Rambler&Co.
"""

import os

if __name__ == '__main__':
    # Получить имя файла и расширение отдельно в кортеже
    print(os.path.splitext('foo.txt'))
