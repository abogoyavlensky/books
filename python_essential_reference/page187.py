"""
    python_essential_reference.page187
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Example of metaclass and descriptor.

    :copyright: (c) 2016 by Rambler&Co.
"""

__all__ = ['Typed', 'Forbidden']


class Forbidden(Exception):
    """Not allowed method"""


class TypedProperty(object):

    def __init__(self, t, default=None):
        self.name = None
        self.type = t
        self.default = default if default is not None else self.type()

    def __get__(self, instance, owner):
        return getattr(instance, self.name, self.default)

    def __set__(self, instance, value):
        if isinstance(value, self.type):
            setattr(instance, self.name, value)
        else:
            raise TypeError('Bad type')

    def __delete__(self, instance):
        raise Forbidden('Deleting is not allowed')


class TypedMeta(type):

    def __new__(cls, name, basic, class_dict):
        slots = []
        for key, value in class_dict.items():
            if isinstance(value, TypedProperty):
                value.name = '_' + key
                slots.append(value.name)
        class_dict.update({'__slots__': slots})
        return type.__new__(cls, name, basic, class_dict)


class Typed(object):
    __metaclass__ = TypedMeta


class Foo(Typed):
    number = TypedProperty(int)
    line = TypedProperty(str, 'empty')


if __name__ == '__main__':
    foo = Foo()
    print(foo.number)
    foo.number = 10
    print(foo.number)
    print(foo.line)
    foo.line = 'New line'
    print(foo.line)
    print(foo)

    #foo.line = 10
    del foo.number
