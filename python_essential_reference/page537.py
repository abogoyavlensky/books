# -*- coding: utf-8 -*-
"""
    python_essential_reference.page537
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Manager and Event.

    :copyright: (c) 2016 by Rambler&Co.
"""

import multiprocessing
import time


# выводит содержимое словаря d всякий раз,
# когда устанавливается переданное событие
def watch(d, evt):
    while True:
        evt.wait()
        print(d)
        evt.clear()


if __name__ == '__main__':
    m = multiprocessing.Manager()
    d = m.dict()
    # Создать разделяемый словарь
    evt = m.Event()
    # Создать разделяемое событие

    # Запустить процесс, который выводит содержимое словаря
    p = multiprocessing.Process(target=watch, args=(d, evt))
    p.daemon = True
    p.start()

    # Добавить элемент словаря и известить процесс вывода его содержимого
    d['foo'] = 42
    evt.set()
    time.sleep(2)

    # Добавить элемент словаря и известить процесс вывода его содержимого
    d['bar'] = 37
    evt.set()
    time.sleep(2)

    # Завершить процесс вывода и процесс менеджера
    p.terminate()
    m.shutdown()
