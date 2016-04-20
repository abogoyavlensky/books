# -*- coding: utf-8 -*-
"""
    python_essential_reference.page524
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Pipe with client/server duplex connection.

    :copyright: (c) 2016 by Rambler&Co.
"""

import multiprocessing

import time


def server(pipe):
    serverp, clientp = pipe
    clientp.close()

    while True:
        try:
            x, y = serverp.recv()
        except EOFError:
            break
        else:
            result = x + y
            serverp.send(result)

            time.sleep(1)

    print('Server stoped.')


def client(pipe):
    serverp, clientp = pipe
    serverp.close()

    clientp.send((10, 5))
    print(clientp.recv())

    clientp.send(('Hello ', 'world!'))
    print(clientp.recv())

    clientp.close()


if __name__ == '__main__':
    serverp, clientp = multiprocessing.Pipe()

    sp = multiprocessing.Process(target=server, args=((serverp, clientp),))
    sp.start()

    client((serverp, clientp))

    sp.join()
