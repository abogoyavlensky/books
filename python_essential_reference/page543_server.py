# -*- coding: utf-8 -*-
"""
    python_essential_reference.page543_server
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Simple server example.

    :copyright: (c) 2016 by Rambler&Co.
"""
from multiprocessing.connection import Listener

if __name__ == '__main__':
    server = Listener(('', 15000), authkey='12345')

    while True:
        conn = server.accept()
        while True:
            try:
                x, y = conn.recv()
            except EOFError:
                break
            else:
                result = x + y
                conn.send(result)
        conn.close()
