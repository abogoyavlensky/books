# -*- coding: utf-8 -*-
"""
    python_essential_reference.page564_client
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Client to work with server with socket.

    :copyright: (c) 2016 by Rambler&Co.
"""
from socket import socket, AF_INET, SOCK_STREAM

PORT = 8888


if __name__ == '__main__':
    s = socket(AF_INET, SOCK_STREAM)
    s.connect(('localhost', PORT))
    t = s.recv(1024)
    s.close()
    print(u'Текущее время: {}'.format(t.decode('ascii')))
