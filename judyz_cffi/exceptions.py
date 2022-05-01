from __future__ import annotations


class JudyError(Exception):
    """Judy error.
    """

    _msgs = [
        "None",
        "Full",
        "Out of Memory",
        "Null PPArray",
        "Null PIndex",
        "Not a Judy1",
        "Not a JudyL",
        "Not a JudySL",
        "Overrun",
        "Corruption",
        "Non-Null PPArray",
        "Null PValue",
        "Unsorted Indexes",
    ]

    def __init__(self, errno):
        # type: (int) -> None
        super(JudyError, self).__init__()
        if 0 <= errno < len(JudyError._msgs):
            self.args = (JudyError._msgs[errno],)
        else:
            self.args = ("Error {}".format(errno),)
