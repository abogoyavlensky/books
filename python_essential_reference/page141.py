def trace(func):

    def callf(*args, **kwargs):
        print('before...')
        results = func(*args, **kwargs)
        print('after')
        return results

    return callf


@trace
def multiple(x, y=1):
    print x * y


if __name__ == '__main__':
    multiple(10, y=2)
