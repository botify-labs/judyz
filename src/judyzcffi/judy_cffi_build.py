# -*- coding: utf-8 -*-

from cffi import FFI

JUDY_CFFI_H = "Judy_cffi.h"

ffi = FFI()
ffi.set_source("_judy_cffi", None)


ffi.cdef(open(JUDY_CFFI_H).read())

if __name__ == "__main__":
    ffi.compile()
