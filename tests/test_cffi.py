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
sys.path.append(os.path.join(path, "../src/judyzcffi"))

from judyz_cffi import Judy1
from judyz_cffi import JudyL


def test_j1_compiled_ok():
    """
    Check miscompiled libJudy
    """
    items = [
        39895168241613, 72383693324832, 395899889036069, 847472082254022,
        946081064318053, 1037167590154045,
        1633874457044695, 1693551557777793, 1699866756097333, 2297933432179674,
        2340748542246111, 2490696201066604,
        2928757784612027, 3419613478295142, 3477583438964521, 3487665594607298,
        3714788097418699, 3721974488148864,
        3758589574777127, 4156020789217938, 4459711081140573, 4682530741276476,
        4731624807195863, 4846840683894723,
        4857387254864689, 4873346723597917, 4966839149608974, 5631406002858271,
        5722255428668219, 5820718729024077,
        6209639118315956, 6406299749329887, 6454295835737737, 6503048444249319,
        6520786252857121, 6906836761168795,
        6926132865086029, 6954533820994232
    ]
    with Judy1() as j:
        for i in items:
            j.add(i)
        assert len(j) == len(items)
        j_items = list(j)
        assert j_items == items


def test_j1_compiled_ok():
    """
    Check miscompiled libJudy
    """
    items = [
        39895168241613, 72383693324832, 395899889036069, 847472082254022,
        946081064318053, 1037167590154045,
        1633874457044695, 1693551557777793, 1699866756097333, 2297933432179674,
        2340748542246111, 2490696201066604,
        2928757784612027, 3419613478295142, 3477583438964521, 3487665594607298,
        3714788097418699, 3721974488148864,
        3758589574777127, 4156020789217938, 4459711081140573, 4682530741276476,
        4731624807195863, 4846840683894723,
        4857387254864689, 4873346723597917, 4966839149608974, 5631406002858271,
        5722255428668219, 5820718729024077,
        6209639118315956, 6406299749329887, 6454295835737737, 6503048444249319,
        6520786252857121, 6906836761168795,
        6926132865086029, 6954533820994232
    ]
    with Judy1() as j:
        for i in items:
            j.add(i)
        assert len(j) == len(items)
        j_items = list(j)
        assert j_items == items


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


def test_j1_signed():
    with Judy1([-1]) as j:
        assert -1 in j
        for k in j:
            assert k == -1


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


def test_jl_from_dict():
    with JudyL({10: 1, 2: 11}) as j:
        d = dict(j)
        assert d == {2L: 11L, 10L: 1L}


def test_jl_from_list():
    with JudyL([(10, 1), (2, 11)]) as j:
        d = dict(j)
        print(d)
        assert d == {2L: 11L, 10L: 1L}


def test_jl_iteritems():
    with JudyL() as j:
        for i in range(10):
            j[i + 10] = i
        i = 0
        start = True
        for k, v in j.iteritems():
            assert k == v + 10
            if start:
                assert k == 10
                start = False
            i += 1
        assert i == 10


def test_jl_keys():
    with JudyL() as j:
        for i in range(10):
            j[i + 10] = i
        i = 0
        start = True
        for k in j.keys():
            if start:
                assert k == 10
                start = False
            i += 1
        assert i == 10


def test_jl_signed():
    with JudyL([(-1, -1)]) as j:
        assert -1 in j
        assert j[-1] == -1
        for k, v in j:
            assert k == -1
            assert v == -1
        for k, v in j.iteritems():
            assert k == -1
            assert v == -1
        for k in j.keys():
            assert k == -1

# TODO: Convert the missing doctests.
