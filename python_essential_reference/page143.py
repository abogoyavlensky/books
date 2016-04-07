def coro(func):

    def start(*args, **kwargs):
        f = func(*args, **kwargs)
        f.next()
        return f

    return start


@coro
def receiver():
    while True:
        n = (yield)
        print 'Recieved: {}'.format(n)


if __name__ == '__main__':
    r = receiver()
    r.send(10)
    r.send('Hello!')
