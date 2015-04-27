# judyz

judyz is another Python wrapper for the [Judy](http://judy.sourceforge.net/)
library.

It's implemented using both [Cython](http://http://cython.org/) and
[CFFI](https://cffi.readthedocs.org/).

`judyz-cython` must be compiled, unlike `judyz-cffi`.

## Compilation Requirements

* libjudy-dev
* cython
* libffi-dev
* python-cffi
* ...


## Distribution

`judyz-cffi` is distributed as source:

    python setup.py sdist

`judyz_cython` can be distributed as an egg:

    python setup.py bdist_egg

To compile `judyz-cython` inplace:

```
cd src/judycython
python setup.py build_ext -i
cd ../..
nosetests
```

## Installation From Local Build

If `pip install` doesn't work:
`pip install --pre --no-index --find-links .../judyz/src/judyzcffi/dist/judyz_cffi-0.1.tar.gz judyz-cffi`

`easy_install .../judyz/src/judyzcython/dist/judyz_cython-0.1-py2.7-linux-x86_64.egg`


## Usage Requirements

* libjudydebian1
* `judyz-cffi`: libffi6

