# judyz

judyz is another Python wrapper for the [Judy](http://judy.sourceforge.net/)
library.

It's implemented using both [Cython](http://http://cython.org/) and
implemented using both [Cython](http://http://cython.org/) and
[CFFI](https://cffi.readthedocs.org/).

`judyz-cython` must be compiled, unlike `judyz-cffi`.

## Compilation Requirements

* libjudy-dev
* cython
* libffi-dev
* python-cffi
* ...


## Distribution

`judyz_cffi` is distributed as source:

    python setup.py sdist

`judyz_cython` can be distributed as an egg:

    python setup.py bdist_egg

To compile `judyz_cython` inplace:

```
cd src/judycython
python setup.py build_ext -i
cd ../..
nosetests
```

## Installation From Local Build

`pip install --pre --no-index --find-links .../judyz/src/judyz-cffi/dist/judyz-cffi-0.1.tar.gz judyz-cffi`

`easy_install .../judyz/src/judyz_cython/dist/judyz_cython-0.1-py2.7-linux-x86_64.egg`


## Usage Requirements

* libjudydebian1
* `judyz-cffi`: libffi6


## Misc

* Why is src/judycython thus named? No special char, not the module's name
