"""
    python_essential_reference.page153
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Example of generator expression.

    :copyright: (c) 2016 by Rambler&Co.
"""

if __name__ == '__main__':
    e = (line for line in open('page40.txt'))
    print(list(e))
