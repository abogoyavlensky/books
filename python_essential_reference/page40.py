import time


def tail(path):
    with open(path) as f:
        f.seek(0, 2)
        while True:
            line = f.readline()
            if not line:
                time.sleep(1)
                continue
            yield line


def grep(lines):
    for line in lines:
        if line.find('python') >= 0:
            yield line


if __name__ == '__main__':
    # to see sys log
    # path = '/var/log/syslog'
    path = 'page40.txt'

    t = tail(path)
    g = grep(t)

    for i in g:
        print(i)
