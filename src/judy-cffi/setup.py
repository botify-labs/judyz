__author__ = 'zeb'
from setuptools import setup

# you must import at least the module(s) that define the ffi's
# that you use in your application
import judy_cffi

setup(
    name="judy-cffi",
    version="0.1",
    py_modules=["judy_cffi"],
    author="Yves Bastide",
    author_email="stid@acm.org",
    description="A CFFI Judy wrapper",
    license="MIT",
    ext_modules=[
        # judy_cffi._ffi.verifier.get_extension(),
    ],
    install_requires=[
        "cffi",
    ],
    zip_safe=False,
    include_package_data=True,
    ##data_files=[('', ['Judy_cffi.h']),],
)
