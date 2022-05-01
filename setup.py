#!/usr/bin/env python
import codecs
import os
from setuptools import setup


# From https://packaging.python.org/en/latest/guides/single-sourcing-package-version/
def read(rel_path):
    here = os.path.abspath(os.path.dirname(__file__))
    with codecs.open(os.path.join(here, rel_path), 'r') as fp:
        return fp.read()


def get_version(rel_path):
    for line in read(rel_path).splitlines():
        if line.startswith('__version__'):
            delim = '"' if '"' in line else "'"
            return line.split(delim)[1]
    else:
        raise RuntimeError("Unable to find version string.")


setup(
    name="judyz-cffi",
    version=get_version("judyz_cffi/__init__.py"),
    long_description=read("README.md"),
    long_description_content_type="text/markdown",
    packages=["judyz_cffi"],
    author="Yves Bastide",
    author_email="yves@botify.com",
    description="Python CFFI Judy wrapper",
    url="https://github.com/botify-labs/judyz",
    setup_requires=["cffi>=1.0.0"],
    cffi_modules=["judyz_cffi/_build.py:ffi"],
    install_requires=["cffi>=1.0.0"],
    include_package_data=True,
    test_suite="tests",
    tests_require=["nose"],
    license=read("LICENSE"),
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: POSIX",
        "Natural Language :: English",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
    ],
)
