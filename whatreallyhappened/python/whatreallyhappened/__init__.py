"""

"""

from __future__ import annotations
from ctypes import *
from os import fspath, fsencode


__all__ = [
    'open',
    'log', 'push', 'pop',
    'save', 'load',
    'write',
]


libwhatreallyhappened = CDLL('libwhatreallyhappened.so')

wrh_open = libwhatreallyhappened.wrh_open
wrh_open.restype = c_int
wrh_open.argtypes = [c_char_p, c_char_p]

wrh_log = libwhatreallyhappened.wrh_log
wrh_log.restype = None
wrh_log.argtypes = [c_char_p, c_char_p, c_char_p]

wrh_push = libwhatreallyhappened.wrh_push
wrh_push.restype = None
wrh_push.argtypes = [c_char_p, c_char_p]

wrh_pop = libwhatreallyhappened.wrh_pop
wrh_pop.restype = None
wrh_pop.argtypes = [c_char_p, c_char_p]

wrh_save = libwhatreallyhappened.wrh_save
wrh_save.restype = None
wrh_save.argtypes = [POINTER(c_char_p)]

wrh_load = libwhatreallyhappened.wrh_load
wrh_load.restype = None
wrh_load.argtypes = [c_char_p]

wrh_write = libwhatreallyhappened.wrh_write
wrh_write.restype = None
wrh_write.argtypes = [c_char_p]


default_encoding = 'utf-8'


class InitializationError(Exception):
    pass


def open(file: PathLike, mode: str='w', *, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    file = fsencode(file)
    mode = mode.encode(encoding)
    ret = wrh_open(file, mode)
    if ret != 0:
        raise InitializationError()


def log(name: str, message: str, *args, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    name = name.encode(encoding)
    formatted = message % args
    formatted = formatted.encode(encoding)
    wrh_log(name, b"%s", formatted)


def push(message: str, *args, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    formatted = message % args
    formatted = formatted.encode(encoding)
    wrh_push(b"%s", formatted)


def pop(message: str, *args, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    formatted = message % args
    formatted = formatted.encode(encoding)
    wrh_pop(b"%s", formatted)


def save(*, encoding=None) -> str:
    if encoding is None:
        encoding = default_encoding

    info = c_char_p(None)
    wrh_save(info)
    info = info.value
    info = info.decode(encoding)
    return info


def load(info: str, *, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    info = info.encode(encoding)
    wrh_load(info)


def write(line: str, *, encoding=None) -> None:
    if encoding is None:
        encoding = default_encoding

    line = line.encode(encoding)
    wrh_write(line)

