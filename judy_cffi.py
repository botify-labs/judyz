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

class Judy1(object):
    pass
