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


@coro
def linebreaker(delimiter=' '):
    result = None
    while True:
        line = (yield result)
        result = line.split(delimiter)


if __name__ == '__main__':
    r = receiver()
    r.send(10)
    r.send('Hello!')

    b = linebreaker(',')
    print(b.send('a,b,c,d'))
    print(b.send('1,2,3,4'))
