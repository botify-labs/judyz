"""
(nose)tests.
"""

# HACK
import sys
import os
import inspect

from nose.tools import raises


path = os.path.dirname(
    os.path.abspath(inspect.getfile(inspect.currentframe())))
sys.path.append(os.path.join(path, "../src"))

from judy_cffi import Judy1
from judy_cffi import JudyL


def test_j1_bool():
    j = Judy1()
    assert not bool(j)
    j.add(42)
    assert bool(j)
    j.clear()


def test_j1_in():
    j = Judy1()
    assert 42 not in j
    j.add(42)
    assert 42 in j
    assert 43 not in j
    j.clear()


def test_j1_len():
    j = Judy1()
    assert len(j) == 0
    j.add(42)
    assert len(j) == 1
    j.add(42)
    assert len(j) == 1
    j.add(2)
    assert len(j) == 2
    j.clear()


@raises(KeyError)
def test_j1_remove_absent():
    with Judy1() as j:
        j.remove(42)


def test_j1_remove():
    with Judy1() as j:
        j.add(42)
        j.remove(42)
        assert len(j) == 0


def test_j1_discard():
    with Judy1() as j:
        j.add(42)
        j.discard(43)
        assert len(j) == 1


def test_j1_from_list():
    with Judy1([6, 5, 4, 3, 2, 1]) as j:
        assert len(j) == 6
        n = 0
        for i in j:
            n += i
        assert n == 21


def test_jl_bool():
    j = JudyL()
    assert not bool(j)
    j[42] = 1
    assert bool(j)
    j.clear()


def test_jl_in():
    j = JudyL()
    assert 42 not in j
    j[42] = 1
    assert 42 in j
    assert 43 not in j
    j.clear()


def test_jl_len():
    with JudyL() as j:
        for i in range(10):
            j[i + 10] = i
        assert len(j) == 10


@raises(KeyError)
def test_jl_getitem_absent():
    with JudyL() as j:
        x = j[12]


def test_jl_get_absent():
    with JudyL() as j:
        x = j.get(12, 1)
        assert x == 1


# TODO: Convert the other doctests.
