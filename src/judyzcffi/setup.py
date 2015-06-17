from setuptools import setup

setup(
    name="judyz-cffi",
    version="0.8.1",
    py_modules=["judyz_cffi"],
    author="Yves Bastide",
    author_email="stid@acm.org",
    description="A CFFI Judy wrapper",
    license="MIT",
    url="https://github.com/botify-labs/judyz",
    setup_requires=["cffi>=1.0.0"],
    cffi_modules=["judy_cffi_build.py:ffi"],
    install_requires=["cffi>=1.0.0"],
)
