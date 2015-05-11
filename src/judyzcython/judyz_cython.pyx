from cpython cimport array as c_array
from array import array
cimport cjudy


class JudyException(Exception):
    """Judy exception.
    """
    def __init__(self, errno):
        super(JudyException, self).__init__()
        self.errno = errno

    def __repr__(self):
        return "<JudyException errno={}>".format(self.errno)


cdef class Judy1:
    """A Judy1 class wrapper.

    >>> j = Judy1()
    >>> bool(j)
    False
    >>> j.add(42)
    >>> 42 in j
    True
    >>> bool(j)
    True
    >>> len(j)
    1
    >>> 42 not in j
    False
    >>> 43 in j
    False
    >>> j.remove(42)
    >>> 42 in j
    False
    >>> j.remove(1)
    Traceback (most recent call last):
        ...
    KeyError: 1L
    >>> j.discard(1)
    >>> len(j)
    0
    >>> bool(j)
    False
    >>> j = Judy1([6,5,4,3,2,1])
    >>> len(j)
    6
    >>> set(j)
    set([1L, 2L, 3L, 4L, 5L, 6L])
    >>> n = 0
    >>> for i in j: n += i
    >>> n
    21L
    """
    cdef cjudy.PJudy1_t _array

    def __cinit__(self):
        self._array = NULL

    def __init__(self, iterable=None):
        if iterable:
            for item in iterable:
                self.add(item)

    def __dealloc__(self):
        cjudy.Judy1FreeArray(&self._array, NULL)

    cpdef __enter__(self):
        return self

    cpdef __exit__(self, exc_type, exc_val, exc_tb):
        self.clear()

    cpdef clear(self):
        cdef cjudy.JError_t err
        if cjudy.Judy1FreeArray(&self._array, NULL) == -1:
            raise JudyException(err.je_Errno)
        self._array = NULL

    cpdef add(self, signed long index):
        cdef cjudy.JError_t err
        if cjudy.Judy1Set(&self._array, index, &err) == -1:
            raise JudyException(err.je_Errno)

    cpdef discard(self, signed long index):
        cdef cjudy.JError_t err
        if cjudy.Judy1Unset(&self._array, index, &err) == -1:
            raise JudyException(err.je_Errno)

    cdef bint c_test(self, signed long index):
        cdef cjudy.JError_t err
        cdef int rc
        rc = cjudy.Judy1Test(self._array, index, &err)
        if rc == -1:
            raise JudyException(err.je_Errno)
        return rc

    cdef long c_len(self):
        cdef cjudy.JError_t err
        cdef int rc
        rc = cjudy.Judy1Count(self._array, 0, -1, &err)
        if rc == 0 and err.je_Errno:
            raise JudyException(err.je_Errno)
        return rc

    cpdef remove(self, signed long index):
        if not self.c_test(index):
            raise KeyError(index)
        self.discard(index)

    def __contains__(self, signed long item):
        return self.c_test(item)

    def __len__(self):
        return self.c_len()

    def __nonzero__(self):
        # XXX does `Del` always zero the array when empty?
        return self._array != NULL and self.c_len() != 0

    def __iter__(self):
        return Judy1Iterator(self)


cdef class Judy1Iterator:
    """
    Iterates on a Judy1.
    """
    cdef Judy1 _j1
    cdef cjudy.PJudy1_t _array
    cdef signed long _index
    cdef short int _start

    def __cinit__(self, Judy1 j1):
        self._j1 = j1
        self._array = j1._array
        self._start = 1
        self._index = 0

    def __iter__(self):
        return self

    def __next__(self):
        cdef cjudy.JError_t err
        cdef int rc
        index = self._index
        if self._start:
            rc = cjudy.Judy1First(self._array, &index, &err)
            self._start = 0
        else:
            rc = cjudy.Judy1Next(self._array, &index, &err)
        if rc == -1:
            raise JudyException(err.je_Errno)
        if rc == 0:
            raise StopIteration()
        self._index = index
        return index


cdef class JudyL:
    """A JudyL class wrapper.

    >>> x = JudyL()
    >>> bool(x)
    False
    >>> x[42] = 43
    >>> len(x)
    1
    >>> bool(x)
    True
    >>> x[42]
    43L
    >>> x[43]
    Traceback (most recent call last):
        ...
    KeyError: 43L
    >>> 42 in x
    True
    >>> 43 in x
    False
    >>> x.get(43)
    0L
    >>> del x[42]
    >>> x[42]
    Traceback (most recent call last):
        ...
    KeyError: 42L
    >>> bool(x)
    False
    >>> x.get(42, 3)
    3L
    >>> len(x)
    0
    >>> x[1]=2
    >>> x[1]
    2L
    >>> dict(x)
    {1L: 2L}
    >>> x.clear()
    >>> len(x)
    0
    >>> bool(x)
    False
    >>> print "a"
    a
    >>> x.update({2: 1, 8: 7, 0: 4})
    >>> for k, v in x: print k, v
    0 4
    2 1
    8 7
    >>> x.clear()
    >>> x = JudyL([(10, 1), (2, 11)])
    >>> dict(x)
    {2L: 11L, 10L: 1L}
    """
    cdef cjudy.PJudyL_t _array

    def __cinit__(self):
        self._array = NULL

    def __init__(self, other=None
                 # , **kwargs
                 ):
        if other is not None:
            self.update(other
                        # , kwargs
                        )

    def __dealloc__(self):
        cjudy.JudyLFreeArray(&self._array, NULL)

    cpdef __enter__(self):
        return self

    cpdef __exit__(self, exc_type, exc_val, exc_tb):
        self.clear()

    cpdef clear(self):
        cjudy.JudyLFreeArray(&self._array, NULL)
        self._array = NULL

    # cdef cjudy.PPvoid_t ins(self, signed long index):
    #     cdef cjudy.JError_t err
    #     cdef cjudy.PPvoid_t p
    #     p = cjudy.JudyLIns(&self._array, index, &err)
    #     if p == NULL:
    #         raise JudyException(err.je_Errno)
    #     return p

    cdef void c_set(self, signed long index, signed long value):
        cdef cjudy.PPvoid_t p
        cdef cjudy.JError_t err
        p = cjudy.JudyLIns(&self._array, index, &err)
        if p == NULL:
            raise JudyException(err.je_Errno)
        p[0] = <void*>value

    cdef cjudy.PPvoid_t c_get(self, signed long index):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        p = cjudy.JudyLGet(self._array, index, &err)
        if p == <cjudy.PPvoid_t>-1:
            raise JudyException(err.je_Errno)
        return p

    cpdef signed long get(self, signed long index, signed long def_value=0):
        cdef cjudy.PPvoid_t p
        p = self.c_get(index)
        if p == NULL:
            return def_value
        return <cjudy.Word_t>p[0]

    cdef signed long c_len(self):
        cdef cjudy.JError_t err
        cdef int rc
        rc = cjudy.JudyLCount(self._array, 0, -1, &err)
        if rc == 0 and err.je_Errno:
            raise JudyException(err.je_Errno)
        return rc

    def __setitem__(self, signed long key, signed long value):
        self.c_set(key, value)

    def __getitem__(self, signed long item):
        cdef cjudy.PPvoid_t p
        p = self.c_get(item)
        if p == NULL:
            raise KeyError(item)
        return <signed long>p[0]

    def __contains__(self, signed long item):
        cdef cjudy.PPvoid_t p
        p = self.c_get(item)
        return p != NULL

    def __delitem__(self, signed long item):
        cdef cjudy.JError_t err
        cdef int rc
        rc = cjudy.JudyLDel(&self._array, item, &err)
        if rc == -1:
            raise JudyException(err.je_Errno)

    def __len__(self):
        return self.c_len()

    def __nonzero__(self):
        # XXX does `Del` always zero the array when empty?
        return self._array != NULL and self.c_len() != 0

    def __iter__(self):
        return JudyLIterator(self)

    def update(self, other=None
               # , **kwargs
               ):
        if other is None:
            return
        has_keys = True
        try:
            other.keys
        except AttributeError:
            has_keys = False
        if has_keys:
            for key in other:
                self.c_set(key, other[key])
        else:
            for (k, v) in other:
                self.c_set(k, v)
        # for k in kwargs:
        #     self.c_set(k, kwargs[k])

    def iteritems(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        cdef signed long index
        index = 0
        p = cjudy.JudyLFirst(self._array, &index, &err)
        if p == <cjudy.PPvoid_t>-1:
            raise JudyException(err.je_Errno)
        if p == NULL:
            return
        yield index, (<cjudy.PWord_t>p)[0]
        while 1:
            p = cjudy.JudyLNext(self._array, &index, &err)
            if p == <cjudy.PPvoid_t>-1:
                raise JudyException(err.je_Errno)
            if p == NULL:
                break
            yield index, (<cjudy.PWord_t>p)[0]

    def keys(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        cdef signed long index
        index = 0
        p = cjudy.JudyLFirst(self._array, &index, &err)
        if p == <cjudy.PPvoid_t>-1:
            raise JudyException(err.je_Errno)
        if p == NULL:
            return
        yield index
        while 1:
            p = cjudy.JudyLNext(self._array, &index, &err)
            if p == <cjudy.PPvoid_t>-1:
                raise JudyException(err.je_Errno)
            if p == NULL:
                break
            yield index


cdef class JudyLIterator:
    """
    Iterates on a JudyL.
    """
    cdef JudyL _j
    cdef cjudy.PJudyL_t _array
    cdef signed long _index
    cdef short int _start

    def __cinit__(self, JudyL j):
        self._j = j
        self._array = j._array
        self._index = 0
        self._start = True

    def __iter__(self):
        return self

    def __next__(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        index = self._index
        if self._start:
            p = cjudy.JudyLFirst(self._array, &index, &err)
            self._start = 0
        else:
            p = cjudy.JudyLNext(self._array, &index, &err)
        if p == <cjudy.PPvoid_t>-1:
            raise JudyException(err.je_Errno)
        if p == NULL:
            raise StopIteration()
        self._index = index
        return index, (<cjudy.PWord_t>p)[0]


cdef class JudySL:
    """
    JudySL class.
    """
    cdef cjudy.PJudySL_t _array
    cdef int _max_len

    def __cinit__(self, other=None):
        self._array = NULL
        self._max_len = 0
        if other:
            self.update(other)

    def __dealloc__(self):
        cjudy.JudySLFreeArray(&self._array, NULL)

    def update(self, other):
        if other is None:
            return
        has_keys = True
        try:
            other.keys
        except AttributeError:
            has_keys = False
        if has_keys:
            for key in other:
                self[key] = other[key]
        else:
            for (k, v) in other:
                self[k] = v

    cdef void c_set(self, cjudy.uint8_t* index, signed long value):
        cdef cjudy.PPvoid_t p
        cdef cjudy.JError_t err
        p = cjudy.JudySLIns(&self._array, index, &err)
        if p == NULL:
            raise JudyException(err.je_Errno)
        p[0] = <cjudy.PPvoid_t> value

    cdef cjudy.PPvoid_t c_get(self, cjudy.uint8_t* index):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        p = cjudy.JudySLGet(self._array, index, &err)
        if p == <cjudy.PPvoid_t> -1:
            raise JudyException(err.je_Errno)
        return p

    def clear(self):
        cdef cjudy.JError_t err
        if cjudy.JudySLFreeArray(&self._array, &err) == -1:
            raise Exception(err.je_Errno)

    def __len__(self):
        it = JudySLIterator(self)
        n = 0
        while 1:
            try:
                next(it)
                n += 1
            except StopIteration:
                break
        return n

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.clear()

    def __setitem__(self, str key, signed long value):
        self.c_set(key, value)
        cur_len = len(key)
        if self._max_len < cur_len:
            self._max_len = cur_len

    def __getitem__(self, str item):
        cdef cjudy.PPvoid_t p
        p = self.c_get(item)
        if p == NULL:
            raise KeyError(item)
        return (<cjudy.PWord_t> p)[0]

    def __contains__(self, str item):
        cdef cjudy.PPvoid_t p
        p = self.c_get(item)
        return p != NULL

    def get(self, str item, default_value=0):
        cdef cjudy.PPvoid_t p
        p = self.c_get(item)
        if p == NULL:
            return default_value
        return (<cjudy.PWord_t> p)[0]

    def __iter__(self):
        return JudySLIterator(self)

    def iteritems(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        cdef c_array.array[cjudy.uint8_t] index_array = array('B', '\0' * (self._max_len + 1))
        cdef cjudy.uint8_t *index = index_array.data.as_uchars
        cdef cjudy.Word_t v
        p = cjudy.JudySLFirst(self._array, index, &err)
        if p == <cjudy.PPvoid_t> -1:
            raise JudyException(err.je_Errno)
        if p == NULL:
            return
        v = (<cjudy.PWord_t> p)[0]
        yield index, v
        while 1:
            p = cjudy.JudySLNext(self._array, index, &err)
            if p == <cjudy.PPvoid_t> -1:
                raise JudyException(err.je_Errno)
            if p == NULL:
                break
        v = (<cjudy.PWord_t> p)[0]
        yield index, v

    def keys(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        cdef c_array.array[cjudy.uint8_t] index_array = array('B',
                                                              '\0' * (self._max_len + 1))
        cdef cjudy.uint8_t *index = index_array.data.as_uchars
        p = cjudy.JudySLFirst(self._array, index, &err)
        if p == <cjudy.PPvoid_t> -1:
            raise JudyException(err.je_Errno)
        if p == NULL:
            return
        yield index
        while 1:
            p = cjudy.JudySLNext(self._array, index, &err)
            if p == <cjudy.PPvoid_t> -1:
                raise JudyException(err.je_Errno)
            if p == NULL:
                break
        yield index

cdef class JudySLIterator:
    """
    Iterates on a JudySL.
    """
    cdef JudySL _j
    cdef cjudy.PJudySL_t _array
    cdef c_array.array[cjudy.uint8_t] index_array
    cdef cjudy.uint8_t *_index
    cdef short int _start

    def __cinit__(self, JudySL j):
        self._j = j
        self._array = j._array
        self._start = True
        self.index_array = array('B', '\0' * (j._max_len + 1))
        self._index = self._index_array.data.as_uchars

    def __iter__(self):
            return self

    def next(self):
        cdef cjudy.JError_t err
        cdef cjudy.PPvoid_t p
        cdef cjudy.Word_t v
        if self._start:
            p = cjudy.JudySLFirst(self._array, self._index, &err)
            self._start = False
        else:
            p = cjudy.JudySLNext(self._array, self._index, &err)
        if p == NULL:
            raise StopIteration()
        if p == <cjudy.PPvoid_t> -1:
            raise Exception(err.je_Errno)
        v = (<cjudy.PWord_t> p)[0]
        return self._index, int(v)
