from distutils.command.install import INSTALL_SCHEMES

__author__ = 'zeb'
from distutils.core import setup
# from setuptools import setup

# you must import at least the module(s) that define the ffi's
# that you use in your application
# noinspection PyUnresolvedReferences
import judyz_cffi

# From http://stackoverflow.com/questions/1612733/including-non-python-files-with-setup-py
for scheme in INSTALL_SCHEMES.values():
    scheme['data'] = scheme['purelib']

setup(
    name="judyz-cffi",
    version="0.3",
    py_modules=["judyz_cffi"],
    author="Yves Bastide",
    author_email="stid@acm.org",
    description="A CFFI Judy wrapper",
    license="MIT",
    url="https://github.com/botify-labs/judyz",
    ext_modules=[
        # none
        # judy_cffi._ffi.verifier.get_extension(),
    ],
    install_requires=[
        "cffi",
    ],
    zip_safe=False,
    include_package_data=True,
    # package_data={
    #     "judy_cffi": ['Judy_cffi.h'],
    #     "judy-cffi": ['Judy_cffi.h'],
    #     },
    data_files=[
        ('', ['Judy_cffi.h']),
    ],
)
