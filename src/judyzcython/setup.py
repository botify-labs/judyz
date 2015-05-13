from setuptools import setup, Extension
# from distutils.core import setup
# from distutils.extension import Extension
from Cython.Build import cythonize

setup(
    name="judyz_cython",
    version="0.5.0",
    author="Yves Bastide",
    author_email="stid@acm.org",
    description="A Cython Judy wrapper",
    license="MIT",
    url="https://github.com/botify-labs/judyz",
    # py_modules=["judyz_cython"],
    ext_modules=cythonize([Extension(
        "judyz_cython", ["judyz_cython.pyx"], libraries=["Judy"])], gdb_debug=False)
)
