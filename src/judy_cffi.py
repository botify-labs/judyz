# -*- coding: utf-8 -*-
"""
CFFI loader for Judy.

Déps:
python-cffi
"""

from cffi import FFI
import inspect
import os


def load():
    ffi = FFI()
    path = os.path.dirname(
        os.path.abspath(inspect.getfile(inspect.currentframe())))
    ffi.cdef(open(os.path.join(path, "Judy_cffi.h")).read())
    cjudy = ffi.dlopen("Judy")
    return ffi, cjudy


_ffi, _cjudy = load()


class Judy1Iterator(object):
    def __init__(self, j):
        self._j = j
        self._array = j._array
        self._start = True
        self._index = _ffi.new("unsigned long*")

    def next(self):
        err = _ffi.new("JError_t *")
        if self._start:
            rc = _cjudy.Judy1First(self._array[0], self._index, err)
            self._start = False
        else:
            rc = _cjudy.Judy1Next(self._array[0], self._index, err)
            self._start = False
        if rc == 0:
            raise StopIteration()
        if rc == -1:
            raise Exception(err.je_Errno)
        return self._index[0]


class Judy1(object):
    """
    Judy1 class.
    """
    def __init__(self, iterable=None):
        self._array = _ffi.new("Judy1 **")
        if iterable:
            for item in iterable:
                self.add(item)

    def add(self, item):
        err = _ffi.new("JError_t *")
        if _cjudy.Judy1Set(self._array, item, err) == -1:
            raise Exception(err.je_Errno)

    def clear(self):
        err = _ffi.new("JError_t *")
        if _cjudy.Judy1FreeArray(self._array, err) == -1:
            raise Exception(err.je_Errno)

    def _get(self, item):
        err = _ffi.new("JError_t *")
        rc = _cjudy.Judy1Test(self._array[0], item, err)
        if rc == -1:
            raise Exception(err.je_Errno)
        return rc

    def __contains__(self, item):
        return self._get(item)

    def __len__(self):
        err = _ffi.new("JError_t *")
        rc = _cjudy.Judy1Count(self._array[0], 0, 1<<63, err)
        if rc == -1:
            raise Exception(err.je_Errno)
        return rc

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.clear()

    def discard(self, item):
        err = _ffi.new("JError_t *")
        rc = _cjudy.Judy1Unset(self._array, item, err)
        if rc == -1:
            raise Exception(err.je_Errno)

    def remove(self, item):
        err = _ffi.new("JError_t *")
        rc = _cjudy.Judy1Unset(self._array, item, err)
        if rc == 0:
            raise KeyError(item)
        if rc == -1:
            raise Exception(err.je_Errno)

    def __iter__(self):
        return Judy1Iterator(self)

class JudyL(object):
    pass
