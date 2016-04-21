# -*- coding: utf-8 -*-
"""
    python_essential_reference.page564_server
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Server with socket.

    :copyright: (c) 2016 by Rambler&Co.
"""
from socket import socket, AF_INET, SOCK_STREAM

import time

PORT = 8888


if __name__ == '__main__':
    s = socket(AF_INET, SOCK_STREAM)
    s.bind(('', PORT))
    s.listen(5)

    while True:
        client, addr = s.accept()
        print(u'Получен запрос на соединение с {}'.format(addr))
        t = time.ctime() + '\r\n'
        client.send(t.encode('ascii'))
        client.close()
