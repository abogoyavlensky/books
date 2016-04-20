# -*- coding: utf-8 -*-
"""
    python_essential_reference.page524
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Queue with signal label.

    :copyright: (c) 2016 by Rambler&Co.
"""

import multiprocessing

import time


def consumer(input_q):
    while True:
        item = input_q.get()
        if item is None:
            break

        print(item)

        time.sleep(1)
        input_q.task_done()


def producer(sequence, input_q):
    for item in sequence:
        input_q.put(item)


if __name__ == '__main__':
    q = multiprocessing.JoinableQueue()

    p = multiprocessing.Process(target=consumer, args=(q,))
    p.daemon = True
    p.start()

    data = [1, 2, 3, 4, 5, 6]
    producer(data, q)

    q.put(None)

    p.join()
