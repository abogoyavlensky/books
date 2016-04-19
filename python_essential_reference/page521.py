"""
    python_essential_reference.page521
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Multiprocessing.

    :copyright: (c) 2016 by Rambler&Co.
"""

import time
import multiprocessing

import logging

console_handler = logging.StreamHandler()
formatter = logging.Formatter('%(levelname)s - %(message)s')
console_handler.setFormatter(formatter)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(console_handler)


def clock(interval):
    while True:
        logger.info('Tick %s', time.ctime())
        time.sleep(interval)


if __name__ == '__main__':
    INTERVAL = 1
    p = multiprocessing.Process(None, target=clock, args=(INTERVAL,))
    p.start()
