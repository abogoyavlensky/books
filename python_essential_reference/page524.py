# -*- coding: utf-8 -*-
"""
    python_essential_reference.page524
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Short description.

    :copyright: (c) 2016 by Rambler&Co.
"""

import multiprocessing

import time


def consumer(input_q):
    while True:
        item = input_q.get()
        print(item)
        time.sleep(2)
        # print(input_q.qsize())
        input_q.task_done()


def producer(sequence, input_q):
    for item in sequence:
        input_q.put(item)


if __name__ == '__main__':
    q = multiprocessing.JoinableQueue()

    p = multiprocessing.Process(target=consumer, args=(q,))
    p.daemon = True
    p.start()

    p2 = multiprocessing.Process(target=consumer, args=(q,))
    p2.daemon = True
    p2.start()

    data = [1, 2, 3, 4, 5, 6]
    producer(data, q)

    q.join()
