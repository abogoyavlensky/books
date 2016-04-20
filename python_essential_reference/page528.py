# -*- coding: utf-8 -*-
"""
    python_essential_reference.page524
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Pipe.

    :copyright: (c) 2016 by Rambler&Co.
"""

import multiprocessing

import time


def consumer(pipe):
    poutput, pinput = pipe
    pinput.close()

    while True:
        try:
            item = poutput.recv()
        except EOFError:
            break
        else:
            print(item)
            time.sleep(1)

    print('Consumer finished.')


def producer(sequence, pinput):
    for item in sequence:
        pinput.send(item)


if __name__ == '__main__':
    poutput, pinput = multiprocessing.Pipe()

    p = multiprocessing.Process(target=consumer, args=((poutput, pinput),))
    p.start()

    poutput.close()

    data = [1, 2, 3, 4, 5, 6]
    producer(data, pinput)

    pinput.close()

    p.join()
