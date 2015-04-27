from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

setup(
    name="judy-cython",
    version="0.1",
    py_modules=["judy_cython"],
    ext_modules=cythonize([Extension(
        "judy_cython", ["judy_cython.pyx"], libraries=["Judy"])])
)
