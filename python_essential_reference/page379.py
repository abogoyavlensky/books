# -*- coding: utf-8 -*-
"""
    python_essential_reference.page379
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Database examples. SQLite.

    :copyright: (c) 2016 by Rambler&Co.
"""
import sqlite3


if __name__ == '__main__':
    conn = sqlite3.connect('example.db')
    c = conn.cursor()

    c.execute('select date, trans, symbol from stocks')
    for date, trans, symbol in c:
        print(date)
        print(trans)
        print(symbol)

    # TODO: uncomment to create table
    # c.execute("""CREATE TABLE stocks
    #              (date text, trans text, symbol text, qty real, price real)""")

    # TODO: uncomment to insert a row of data
    # c.execute("""INSERT INTO stocks
    #              VALUES ('2006-01-05','BUY','RHAT',100,35.14)""")

    # Save (commit) the changes
    conn.commit()
    conn.close()
