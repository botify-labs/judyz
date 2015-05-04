#ifndef _JUDY_INCLUDED
#define _JUDY_INCLUDED

// Define a bunch of stuff then import Judy_cffi.h.

// _________________
//
// Copyright (C) 2000 - 2002 Hewlett-Packard Company
//
// This program is free software; you can redistribute it and/or modify it
// under the term of the GNU Lesser General Public License as published by the
// Free Software Foundation; either version 2 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
// for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program; if not, write to the Free Software Foundation,
// Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// _________________

// @(#) $Revision: 4.52 $ $Source: /judy/src/Judy.h $
//
// HEADER FILE FOR EXPORTED FEATURES IN JUDY LIBRARY, libJudy.*
//
// See the manual entries for details.
//
// Note:  This header file uses old-style comments on #-directive lines and
// avoids "()" on macro names in comments for compatibility with older cc -Aa
// and some tools on some platforms.


// PLATFORM-SPECIFIC

#ifdef JU_WIN /* =============================================== */

typedef __int8           int8_t;
typedef __int16          int16_t;
typedef __int32          int32_t;
typedef __int64          int64_t;

typedef unsigned __int8  uint8_t;
typedef unsigned __int16 uint16_t;
typedef unsigned __int32 uint32_t;
typedef unsigned __int64 uint64_t;

#else /* ================ ! JU_WIN ============================= */

// ISO C99: 7.8 Format conversion of integer types <inttypes.h>
#include <inttypes.h>  /* if this FAILS, try #include <stdint.h> */ 

// ISO C99: 7.18 Integer types uint*_t 
//#include <stdint.h>  

#endif /* ================ ! JU_WIN ============================= */

// ISO C99 Standard: 7.20 General utilities
#include <stdlib.h>  

// ISO C99 Standard: 7.10/5.2.4.2.1 Sizes of integer types
#include <limits.h>  

#ifdef __cplusplus      /* support use by C++ code */
extern "C" {
#endif

#include "../judyzcffi/Judy_cffi.h"


#ifdef __cplusplus
}
#endif
#endif /* ! _JUDY_INCLUDED */
