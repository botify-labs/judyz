# judyz

judyz is another Python wrapper for the [Judy](http://judy.sourceforge.net/)
library.

It's implemented using both [Cython](http://http://cython.org/) and
[CFFI](https://cffi.readthedocs.org/).


## Compilation Requirements

* libjudy-dev
* cython
* ffi
* python-cffi
* ...

To compile `judy_cython` inplace:

```
cd src
python setup_cython.py build_ext -i
cd ..
nosetests
```


## Use Requirements

* libjudydebian1
* a symbolic link libJudy.so -> libJudy.so.1?
* ffi


