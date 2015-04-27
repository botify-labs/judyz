from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

setup(
    ext_modules=cythonize([Extension("judy_cython", ["judy_cython.pyx"], libraries=["Judy"])])
)
