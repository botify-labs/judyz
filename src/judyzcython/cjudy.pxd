cdef extern from "./Judy_cython.h":
    ctypedef void *Pvoid_t
    ctypedef void *Pcvoid_t
    ctypedef void **PPvoid_t
    ctypedef signed long Word_t
    ctypedef signed long *PWord_t
    ctypedef unsigned char uint8_t

    ctypedef struct _Judy1:
        pass
    ctypedef const _Judy1* PcJudy1_t
    ctypedef _Judy1* PJudy1_t
    ctypedef _Judy1** PPJudy1_t

    ctypedef struct _JudyL:
        pass
    ctypedef const _JudyL  *PcJudyL_t
    ctypedef _JudyL* PJudyL_t
    ctypedef _JudyL** PPJudyL_t

    ctypedef struct _JudySL:
        pass
    ctypedef const _JudySL  *PcJudySL_t
    ctypedef _JudySL* PJudySL_t
    ctypedef _JudySL** PPJudySL_t

    ctypedef struct JError_t:
        int je_Errno
        int je_ErrID
        Word_t je_reserved[4]

    ctypedef JError_t *PJError_t

    int      Judy1Test(PcJudy1_t  PArray, Word_t   Index, PJError_t PJError)
    int      Judy1Set(PPJudy1_t PPArray, Word_t   Index, PJError_t PJError)
    int      Judy1SetArray(PPJudy1_t PPArray, Word_t   Count, const PWord_t PIndex, PJError_t PJError)
    int      Judy1Unset(PPJudy1_t PPArray, Word_t   Index, PJError_t PJError)
    Word_t   Judy1Count(PcJudy1_t  PArray, Word_t   Index1, Word_t   Index2, PJError_t PJError)
    int      Judy1ByCount(PcJudy1_t  PArray, Word_t   Count, PWord_t PIndex, PJError_t PJError)
    Word_t   Judy1FreeArray(PPJudy1_t PPArray, PJError_t PJError)
    Word_t   Judy1MemUsed(PcJudy1_t  PArray)
    Word_t   Judy1MemActive(PcJudy1_t  PArray)
    int      Judy1First(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1Next(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1Last(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1Prev(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1FirstEmpty(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1NextEmpty(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1LastEmpty(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)
    int      Judy1PrevEmpty(PcJudy1_t  PArray, PWord_t PIndex, PJError_t PJError)

    void** JudyLGet(PcJudyL_t PArray, Word_t Index, PJError_t PJError)
    void** JudyLIns(PPJudyL_t PPArray, Word_t Index, PJError_t PJError)
    int JudyLInsArray(PPJudyL_t PPArray, unsigned int Count, const PWord_t  PIndex, const PWord_t  PValue, PJError_t PJError)
    int JudyLDel(PPJudyL_t PPArray, Word_t Index, PJError_t PJError)
    unsigned int JudyLCount(PcJudyL_t PArray, Word_t Index1, Word_t Index2, PJError_t PJError)
    void** JudyLByCount(PcJudyL_t PArray, unsigned int Count, PWord_t PIndex, PJError_t PJError)
    unsigned int JudyLFreeArray(PPJudyL_t PPArray, PJError_t PJError)
    unsigned int JudyLMemUsed(PcJudyL_t PArray)
    unsigned int JudyLMemActive(PcJudyL_t PArray)
    void** JudyLFirst(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    void** JudyLNext(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    void** JudyLLast(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    void** JudyLPrev(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    int JudyLFirstEmpty(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    int JudyLNextEmpty(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    int JudyLLastEmpty(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)
    int JudyLPrevEmpty(PcJudyL_t PArray, PWord_t PIndex, PJError_t PJError)

    void** JudySLGet(PcJudySL_t PArray, const uint8_t *Index, PJError_t PJError)
    void** JudySLIns(PPJudySL_t PPArray, const uint8_t *Index, PJError_t PJError)
    int JudySLDel(PPJudySL_t PPArray, const uint8_t *Index, PJError_t PJError)
    unsigned int JudySLFreeArray(PPJudySL_t PPArray, PJError_t PJError)
    void** JudySLFirst(PcJudySL_t PArray, uint8_t *Index, PJError_t PJError)
    void** JudySLNext(PcJudySL_t PArray, uint8_t *Index, PJError_t PJError)
    void** JudySLLast(PcJudySL_t PArray, uint8_t *Index, PJError_t PJError)
    void** JudySLPrev(PcJudySL_t PArray, uint8_t *Index, PJError_t PJError)
