def coro():
    while True:
        n = (yield)
        print 'Recieved: {}'.format(n)


if __name__ == '__main__':
    c = coro()
    c.next()
    c.send(10)
    c.send('Hello!')
