def foo(line):
    def print_line():
        print line
    return print_line

if __name__ == '__main__':
    first = foo('Hello')
    space = foo(' ')
    second = foo('python!')

    first()
    space()
    second()

    print first.__closure__[0].cell_contents
