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


if __name__ == '__main__':
    # to see sys log
    # for i in tail('/var/log/syslog'):
    for i in tail('page40.txt'):
        print(i)
