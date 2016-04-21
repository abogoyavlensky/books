# -*- coding: utf-8 -*-
"""
    python_essential_reference.page543_client
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Simple client example.

    :copyright: (c) 2016 by Rambler&Co.
"""
from multiprocessing.connection import Client

if __name__ == '__main__':
    conn = Client(('localhost', 15000), authkey='12345')

    conn.send((3, 4))
    print(conn.recv())

    conn.send(('Hello ', 'world!'))
    print(conn.recv())

    conn.close()
