//--------------------------------------------------------------------------------
// @file  AtrType.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

public let ATR_NOTQRS     : UInt8 = (0)       // 0  0 not-QRS (not a getann/putann code)
public let ATR_NORMAL     : UInt8 = (1)       // 1  N normal beat
public let ATR_LBBB       : UInt8 = (2)       // 2  L left bundle branch block beat
public let ATR_RBBB       : UInt8 = (3)       // 3  R right bundle branch block beat
public let ATR_ABERR      : UInt8 = (4)       // 4  a aberrated atrial premature beat
public let ATR_PVC        : UInt8 = (5)       // 5  V premature ventricular contraction
public let ATR_FUSION     : UInt8 = (6)       // 6  F fusion of ventricular and normal beat
public let ATR_NPC        : UInt8 = (7)       // 7  J nodal (junctional) premature beat
public let ATR_APC        : UInt8 = (8)       // 8  A atrial premature contraction
public let ATR_SVPB       : UInt8 = (9)       // 9  S premature or ectopic supraventricular beat
public let ATR_VESC       : UInt8 = (10)      // 10 E ventricular escape beat
public let ATR_NESC       : UInt8 = (11)      // 11 j nodal (junctional) escape beat
public let ATR_PACE       : UInt8 = (12)      // 12 / paced beat
public let ATR_UNKNOWN    : UInt8 = (13)      // 13 Q unclassifiable beat
public let ATR_NOISE      : UInt8 = (14)      // 14 ~ signal quality change
public let ATR_15         : UInt8 = (15)      // 15 # ATR = 15
public let ATR_ARFCT      : UInt8 = (16)      // 16 | isolated QRS-like artifact
public let ATR_17         : UInt8 = (15)      // 17 # ATR = 17
public let ATR_STCH       : UInt8 = (18)      // 18 s ST change
public let ATR_TCH        : UInt8 = (19)      // 19 T T-wave change
public let ATR_SYSTOLE    : UInt8 = (20)      // 20 * systole
public let ATR_DIASTOLE   : UInt8 = (21)      // 21 D diastole
public let ATR_NOTE       : UInt8 = (22)      // 22 " comment annotation
public let ATR_MEASURE    : UInt8 = (23)      // 23 = measurement annotation
public let ATR_PWAVE      : UInt8 = (24)      // 24 P P-wave peak
public let ATR_BBB        : UInt8 = (25)      // 25 B left or right bundle branch block
public let ATR_PACESP     : UInt8 = (26)      // 26 ^ non-conducted pacer spike
public let ATR_TWAVE      : UInt8 = (27)      // 27 t T-wave peak
public let ATR_RHYTHM     : UInt8 = (28)      // 28 + rhythm change
public let ATR_UWAVE      : UInt8 = (29)      // 29 u U-wave peak
public let ATR_LEARN      : UInt8 = (30)      // 30 ? learning
public let ATR_FLWAV      : UInt8 = (31)      // 31 ! ventricular flutter wave
public let ATR_VFON       : UInt8 = (32)      // 32 [ start of ventricular flutter/fibrillation
public let ATR_VFOFF      : UInt8 = (33)      // 33 ] end of ventricular flutter/fibrillation
public let ATR_AESC       : UInt8 = (34)      // 34 e atrial escape beat
public let ATR_SVESC      : UInt8 = (35)      // 35 n supraventricular escape beat
public let ATR_LINK       : UInt8 = (36)      // 36 @ link to external data (aux contains URL)
public let ATR_NAPC       : UInt8 = (37)      // 37 x non-conducted P-wave (blocked APB)
public let ATR_PFUS       : UInt8 = (38)      // 38 f fusion of paced and normal beat
public let ATR_WFON       : UInt8 = (39)      // 39 ( waveform onset
public let ATR_WFOFF      : UInt8 = (40)      // 40 ) waveform end
public let ATR_RONT       : UInt8 = (41)      // 41 r R-on-T premature ventricular contraction
public let ATR_UNREADABLE   : UInt8 = (42)
public let ATR_UNREADABLES  : UInt8 = (43)    // ATR_UNREADABLES
public let ATR_UNREADABLEE  : UInt8 = (44)    // ATR_UNREADABLEE
public let ATR_NONE       : UInt8 = (255)     //< ADD by JL

//----------------------------------------//
// [JL] for console program of JCNN
//----------------------------------------//
public let LABEL_NOTQRS   : String = "[NOTQRS]"            // 0 not-QRS (not a getann/putann code)
public let LABEL_NORMAL   : String = "NORMAL"              // 1 normal beat
public let LABEL_LBBB     : String = "LBBB"                // 2 left bundle branch block beat
public let LABEL_RBBB     : String = "RBBB"                // 3 right bundle branch block beat
public let LABEL_ABERR    : String = "ABERR"              // 4 aberrated atrial premature beat
public let LABEL_PVC      : String = "PVC"                // 5 premature ventricular contraction
public let LABEL_FUSION   : String = "FUSION"              // 6 fusion of ventricular and normal beat
public let LABEL_NPC      : String = "NPC"                // 7 nodal (junctional) premature beat
public let LABEL_APC      : String = "APC"                 // 8 atrial premature contraction
public let LABEL_SVPB     : String = "SVPB"                 // 9 premature or ectopic supraventricular beat
public let LABEL_VESC     : String = "VESC"                 // 10 ventricular escape beat
public let LABEL_NESC     : String = "NESC"                 // 11 nodal (junctional) escape beat
public let LABEL_PACE     : String = "PACE"                 // 12 paced beat
public let LABEL_UNKNOWN  : String = "UNKNOWN"             // 13 unclassifiable beat
public let LABEL_NOISE    : String = "NOISE"               // 14 signal quality change
public let LABEL_ATR_15   : String = "15"                  // 15 ATR = 15
public let LABEL_ARFCT    : String = "ARFCT"               // 16 isolated QRS-like artifact
public let LABEL_ATR_17   : String = "17"                  // 17 ATR = 17
public let LABEL_STCH     : String = "STCH"                 // 18 ST change
public let LABEL_TCH      : String = "TCH"                 // 19 T-wave change
public let LABEL_SYSTOLE  : String = "SYSTOLE"             // 20 systole
public let LABEL_DIASTOLE : String = "DIASTOLE"             // 21 diastole
public let LABEL_NOTE     : String = "NOTE"                 // 22 comment annotation
public let LABEL_MEASURE  : String = "MEASURE"             // 23 measurement annotation
public let LABEL_PWAVE    : String = "PWAVE"               // 24 P-wave peak
public let LABEL_BBB      : String = "BBB"                 // 25 left or right bundle branch block
public let LABEL_PACESP   : String = "PACESP"               // 26 non-conducted pacer spike
public let LABEL_TWAVE    : String = "TWAVE"               // 27 T-wave peak
public let LABEL_RHYTHM   : String = "RHYTHM"               // 28 rhythm change
public let LABEL_UWAVE    : String = "UWAVE"               // 29 U-wave peak
public let LABEL_LEARN    : String = "LEARN"               // 30 learning
public let LABEL_FLWAV    : String = "FLWAV"               // 31 ventricular flutter wave
public let LABEL_VFON     : String = "VFON"                 // 32 start of ventricular flutter/fibrillation
public let LABEL_VFOFF    : String = "VFOFF"               // 33 end of ventricular flutter/fibrillation
public let LABEL_AESC     : String = "AESC"                 // 34 atrial escape beat
public let LABEL_SVESC    : String = "SVESC"               // 35 supraventricular escape beat
public let LABEL_LINK     : String = "LINK"                // 36 link to external data (aux contains URL)
public let LABEL_NAPC     : String = "NAPC"                 // 37 non-conducted P-wave (blocked APB)
public let LABEL_PFUS     : String = "PFUS"                 // 38 fusion of paced and normal beat
public let LABEL_WFON     : String = "WFON"                 // 39 waveform onset
public let LABEL_WFOFF    : String = "WFOFF"               // 40 waveform end
public let LABEL_RONT     : String = "RONT"                // 41 R-on-T premature ventricular contraction

public let LABEL_ATR_42   : String = "U"                   // 42 ATR
public let LABEL_ATR_43   : String = "U0"                  // 43 ATR
public let LABEL_ATR_44   : String = "U1"                  // 44 ATR
public let LABEL_ATR_45   : String = "45"                  // 45 ATR
public let LABEL_ATR_46   : String = "46"                  // 46 ATR
public let LABEL_ATR_47   : String = "47"                  // 47 ATR
public let LABEL_ATR_48   : String = "48"                  // 48 ATR
public let LABEL_ATR_49   : String = "49"                  // 49 ATR

public let LABEL_ATR_50   : String = "50"                  // 50 ATR
public let LABEL_ATR_51   : String = "51"                  // 51 ATR
public let LABEL_ATR_52   : String = "52"                  // 52 ATR
public let LABEL_ATR_53   : String = "53"                  // 53 ATR
public let LABEL_ATR_54   : String = "54"                  // 54 ATR
public let LABEL_ATR_55   : String = "55"                  // 55 ATR
public let LABEL_ATR_56   : String = "56"                  // 56 ATR
public let LABEL_ATR_57   : String = "57"                  // 57 ATR
public let LABEL_ATR_58   : String = "58"                  // 58 ATR
public let LABEL_ATR_SKIP : String = "[SKIP]"              // 59 the next four bytes are the interval in PDP-11 long integer format (the high 16 bits first, then the low 16 bits, with the low byte first in each pair).

public let LABEL_ATR_NUM   : String = "[NUM]"              // 60 annotation num field for current and subsequent annotations; otherwise, assume previous annotation num (initially 0).
public let LABEL_ATR_SUB   : String = "[SUB]"              // 61 annotation subtyp field for current annotation only; otherwise, assume subtyp = 0.
public let LABEL_ATR_CHN   : String = "[CHN]"              // 62 annotation chan field for current and subsequent annotations; otherwise, assume previous chan (initially 0).
public let LABEL_ATR_AUX   : String = "[AUX]"              // 63 number of bytes of auxiliary information (which is contained in the next I bytes); an extra null, not included in the byte count, is appended if I is odd.


public let ABBREV_NOTQRS      : String = "NOTQRS"          // 0 not-QRS (not a getann/putann code)
public let ABBREV_NORMAL      : String = "N"               // 1 normal beat
public let ABBREV_LBBB        : String = "L"               // 2 left bundle branch block beat
public let ABBREV_RBBB        : String = "R"               // 3 right bundle branch block beat
public let ABBREV_ABERR       : String = "a"               // 4 aberrated atrial premature beat
public let ABBREV_PVC         : String = "V"               // 5 premature ventricular contraction
public let ABBREV_FUSION      : String = "F"               // 6 fusion of ventricular and normal beat
public let ABBREV_NPC         : String = "J"               // 7 nodal (Junctional) premature beat
public let ABBREV_APC         : String = "A"               // 8 atrial premature contraction
public let ABBREV_SVPB        : String = "S"               // 9 premature or ectopic supraventricular beat
public let ABBREV_VESC        : String = "E"               // 10 ventricular escape beat
public let ABBREV_NESC        : String = "j"               // 11 nodal (junctional) escape beat
public let ABBREV_PACE        : String = "//"              // 12 paced beat
public let ABBREV_UNKNOWN     : String = "Q"               // 13 unclassifiable beat
public let ABBREV_NOISE       : String = "~"               // 14 signal quality change
public let ABBREV_ATR_15      : String = "15"              // 15 ATR = 15
public let ABBREV_ARFCT       : String = "|"               // 16 isolated QRS-like artifact
public let ABBREV_ATR_17      : String = "17"              // 17 ATR = 17
public let ABBREV_STCH        : String = "s"               // 18 ST change
public let ABBREV_TCH         : String = "T"               // 19 T-wave change
public let ABBREV_SYSTOLE     : String = "*"               // 20 systole
public let ABBREV_DIASTOLE    : String = "D"               // 21 diastole
public let ABBREV_NOTE        : String = "\""              // 22 comment annotation
public let ABBREV_MEASURE     : String = "="               // 23 measurement annotation
public let ABBREV_PWAVE       : String = "P"               // 24 P-wave peak
public let ABBREV_BBB         : String = "B"               // 25 left or right bundle branch block
public let ABBREV_PACESP      : String = "^"               // 26 non-conducted pacer spike
public let ABBREV_TWAVE       : String = "t"               // 27 T-wave peak
public let ABBREV_RHYTHM      : String = "+"               // 28 rhythm change
public let ABBREV_UWAVE       : String = "u"               // 29 U-wave peak
public let ABBREV_LEARN       : String = "?"               // 30 learning
public let ABBREV_FLWAV       : String = "!"               // 31 ventricular flutter wave
public let ABBREV_VFON        : String = "["               // 32 start of ventricular flutter/fibrillation
public let ABBREV_VFOFF       : String = "]"               // 33 end of ventricular flutter/fibrillation
public let ABBREV_AESC        : String = "e"               // 34 atrial escape beat
public let ABBREV_SVESC       : String = "n"               // 35 supraventricular escape beat
public let ABBREV_LINK        : String = "@"               // 36 link to external data (aux contains URL)
public let ABBREV_NAPC        : String = "x"               // 37 non-conducted P-wave (blocked APB)
public let ABBREV_PFUS        : String = "f"               // 38 fusion of paced and normal beat
public let ABBREV_WFON        : String = "("               // 39 waveform onset
public let ABBREV_WFOFF       : String = ")"               // 40 waveform end
public let ABBREV_RONT        : String = "RONT"            // 41 R-on-T premature ventricular contraction

public let ABBREV_ATR_42      : String = "U"               // 42 ATR
public let ABBREV_ATR_43      : String = "U0"              // 43 ATR
public let ABBREV_ATR_44      : String = "U1"              // 44 ATR
public let ABBREV_ATR_45      : String = "45"              // 45 ATR
public let ABBREV_ATR_46      : String = "46"              // 46 ATR
public let ABBREV_ATR_47      : String = "47"              // 47 ATR
public let ABBREV_ATR_48      : String = "48"              // 48 ATR
public let ABBREV_ATR_49      : String = "49"              // 49 ATR

public let ABBREV_ATR_50      : String = "50"              // 50 ATR
public let ABBREV_ATR_51      : String = "51"              // 51 ATR
public let ABBREV_ATR_52      : String = "52"              // 52 ATR
public let ABBREV_ATR_53      : String = "53"              // 53 ATR
public let ABBREV_ATR_54      : String = "54"              // 54 ATR
public let ABBREV_ATR_55      : String = "55"              // 55 ATR
public let ABBREV_ATR_56      : String = "56"              // 56 ATR
public let ABBREV_ATR_57      : String = "57"              // 57 ATR
public let ABBREV_ATR_58      : String = "58"              // 58 ATR
public let ABBREV_ATR_SKIP    : String = "[SKIP]"          // 59 the next four bytes are the interval in PDP-11 long integer format (the high 16 bits first, then the low 16 bits, with the low byte first in each pair).

public let ABBREV_ATR_NUM     : String = "[NUM]"           // 60 annotation num field for current and subsequent annotations; otherwise, assume previous annotation num (initially 0).
public let ABBREV_ATR_SUB     : String = "[SUB]"           // 61 annotation subtyp field for current annotation only; otherwise, assume subtyp = 0.
public let ABBREV_ATR_CHN     : String = "[CHN]"           // 62 annotation chan field for current and subsequent annotations; otherwise, assume previous chan (initially 0).
public let ABBREV_ATR_AUX     : String = "[AUX]"           // 63 number of bytes of auxiliary information (which is contained in the next I bytes); an extra null, not included in the byte count, is appended if I is odd.

public let JAtrLabel : [String] =
[
    LABEL_NOTQRS    ,   //< 0 not-QRS (not a getann/putann code)
    LABEL_NORMAL    ,   //< 1 normal beat
    LABEL_LBBB      ,   //< 2 left bundle branch block beat
    LABEL_RBBB      ,   //< 3 right bundle branch block beat
    LABEL_ABERR     ,   //< 4 aberrated atrial premature beat
    LABEL_PVC       ,   //< 5 premature ventricular contraction
    LABEL_FUSION    ,   //< 6 fusion of ventricular and normal beat
    LABEL_NPC       ,   //< 7 nodal (junctional) premature beat
    LABEL_APC       ,   //< 8 atrial premature contraction
    LABEL_SVPB      ,   //< 9 premature or ectopic supraventricular beat
    LABEL_VESC      ,   //< 10 ventricular escape beat
    LABEL_NESC      ,   //< 11 nodal (junctional) escape beat
    LABEL_PACE      ,   //< 12 paced beat
    LABEL_UNKNOWN   ,   //< 13 unclassifiable beat
    LABEL_NOISE     ,   //< 14 signal quality change
    LABEL_ATR_15    ,   //< 15 ATR = 15
    LABEL_ARFCT     ,   //< 16 isolated QRS-like artifact
    LABEL_ATR_17    ,   //< 17 ATR = 17
    LABEL_STCH      ,   //< 18 ST change
    LABEL_TCH       ,   //< 19 T-wave change
    LABEL_SYSTOLE   ,   //< 20 systole
    LABEL_DIASTOLE  ,   //< 21 diastole
    LABEL_NOTE      ,   //< 22 comment annotation
    LABEL_MEASURE   ,   //< 23 measurement annotation
    LABEL_PWAVE     ,   //< 24 P-wave peak
    LABEL_BBB       ,   //< 25 left or right bundle branch block
    LABEL_PACESP    ,   //< 26 non-conducted pacer spike
    LABEL_TWAVE     ,   //< 27 T-wave peak
    LABEL_RHYTHM    ,   //< 28 rhythm change
    LABEL_UWAVE     ,   //< 29 U-wave peak
    LABEL_LEARN     ,   //< 30 learning
    LABEL_FLWAV     ,   //< 31 ventricular flutter wave
    LABEL_VFON      ,   //< 32 start of ventricular flutter/fibrillation
    LABEL_VFOFF     ,   //< 33 end of ventricular flutter/fibrillation
    LABEL_AESC      ,   //< 34 atrial escape beat
    LABEL_SVESC     ,   //< 35 supraventricular escape beat
    LABEL_LINK      ,   //< 36 link to external data (aux contains URL)
    LABEL_NAPC      ,   //< 37 non-conducted P-wave (blocked APB)
    LABEL_PFUS      ,   //< 38 fusion of paced and normal beat
    LABEL_WFON      ,   //< 39 waveform onset
    LABEL_WFOFF     ,   //< 40 waveform end
    LABEL_RONT      ,   //< 41 R-on-T premature ventricular contraction
    LABEL_ATR_42    ,   //< 42
    LABEL_ATR_43    ,   //< 43
    LABEL_ATR_44    ,   //< 44
    LABEL_ATR_45    ,   //< 45
    LABEL_ATR_46    ,   //< 46
    LABEL_ATR_47    ,   //< 47
    LABEL_ATR_48    ,   //< 48
    LABEL_ATR_49    ,   //< 49

    LABEL_ATR_50    ,   //< 50
    LABEL_ATR_51    ,   //< 51
    LABEL_ATR_52    ,   //< 52
    LABEL_ATR_53    ,   //< 53
    LABEL_ATR_54    ,   //< 54
    LABEL_ATR_55    ,   //< 55
    LABEL_ATR_56    ,   //< 56
    LABEL_ATR_57    ,   //< 57
    LABEL_ATR_58    ,   //< 58

    LABEL_ATR_SKIP  ,   //< 59 SKIP

    LABEL_ATR_NUM   ,   //< 60 NUM
    LABEL_ATR_SUB   ,   //< 61 SUB
    LABEL_ATR_CHN   ,   //< 62 CHN
    LABEL_ATR_AUX   ,   //< 63 AUX
  ];

public let JAtrAbbrev : [String] =
[
  ABBREV_NOTQRS     ,   //< 0 not-QRS (not a getann/putann code)
  ABBREV_NORMAL     ,   //< 1 normal beat
  ABBREV_LBBB       ,   //< 2 left bundle branch block beat
  ABBREV_RBBB       ,   //< 3 right bundle branch block beat
  ABBREV_ABERR      ,   //< 4 aberrated atrial premature beat
  ABBREV_PVC        ,   //< 5 premature ventricular contraction
  ABBREV_FUSION     ,   //< 6 fusion of ventricular and normal beat
  ABBREV_NPC        ,   //< 7 nodal (junctional) premature beat
  ABBREV_APC        ,   //< 8 atrial premature contraction
  ABBREV_SVPB       ,   //< 9 premature or ectopic supraventricular beat
  ABBREV_VESC       ,   //< 10 ventricular escape beat
  ABBREV_NESC       ,   //< 11 nodal (junctional) escape beat
  ABBREV_PACE       ,   //< 12 paced beat
  ABBREV_UNKNOWN    ,   //< 13 unclassifiable beat
  ABBREV_NOISE      ,   //< 14 signal quality change
  ABBREV_ATR_15     ,   //< 15 ATR = 15
  ABBREV_ARFCT      ,   //< 16 isolated QRS-like artifact
  ABBREV_ATR_17     ,   //< 17 ATR = 17
  ABBREV_STCH       ,   //< 18 ST change
  ABBREV_TCH        ,   //< 19 T-wave change
  ABBREV_SYSTOLE    ,   //< 20 systole
  ABBREV_DIASTOLE   ,   //< 21 diastole
  ABBREV_NOTE       ,   //< 22 comment annotation
  ABBREV_MEASURE    ,   //< 23 measurement annotation
  ABBREV_PWAVE      ,   //< 24 P-wave peak
  ABBREV_BBB        ,   //< 25 left or right bundle branch block
  ABBREV_PACESP     ,   //< 26 non-conducted pacer spike
  ABBREV_TWAVE      ,   //< 27 T-wave peak
  ABBREV_RHYTHM     ,   //< 28 rhythm change
  ABBREV_UWAVE      ,   //< 29 U-wave peak
  ABBREV_LEARN      ,   //< 30 learning
  ABBREV_FLWAV      ,   //< 31 ventricular flutter wave
  ABBREV_VFON       ,   //< 32 start of ventricular flutter/fibrillation
  ABBREV_VFOFF      ,   //< 33 end of ventricular flutter/fibrillation
  ABBREV_AESC       ,   //< 34 atrial escape beat
  ABBREV_SVESC      ,   //< 35 supraventricular escape beat
  ABBREV_LINK       ,   //< 36 link to external data (aux contains URL)
  ABBREV_NAPC       ,   //< 37 non-conducted P-wave (blocked APB)
  ABBREV_PFUS       ,   //< 38 fusion of paced and normal beat
  ABBREV_WFON       ,   //< 39 waveform onset
  ABBREV_WFOFF      ,   //< 40 waveform end
  ABBREV_RONT       ,   //< 41 R-on-T premature ventricular contraction
  ABBREV_ATR_42     ,   //< 42
  ABBREV_ATR_43     ,   //< 43
  ABBREV_ATR_44     ,   //< 44
  ABBREV_ATR_45     ,   //< 45
  ABBREV_ATR_46     ,   //< 46
  ABBREV_ATR_47     ,   //< 47
  ABBREV_ATR_48     ,   //< 48
  ABBREV_ATR_49     ,   //< 49

  ABBREV_ATR_50     ,   //< 50
  ABBREV_ATR_51     ,   //< 51
  ABBREV_ATR_52     ,   //< 52
  ABBREV_ATR_53     ,   //< 53
  ABBREV_ATR_54     ,   //< 54
  ABBREV_ATR_55     ,   //< 55
  ABBREV_ATR_56     ,   //< 56
  ABBREV_ATR_57     ,   //< 57
  ABBREV_ATR_58     ,   //< 58

  ABBREV_ATR_SKIP   ,   //< 59 SKIP

  ABBREV_ATR_NUM    ,   //< 60 NUM
  ABBREV_ATR_SUB    ,   //< 61 SUB
  ABBREV_ATR_CHN    ,   //< 62 CHN
  ABBREV_ATR_AUX    ,   //< 63 AUX
]

class JAtrType : NSObject
{
  var bAtr      : UInt8  = 0
  var dwMS      : UInt32 = 0 //< milliseconds since VSC_MODE_START_TIME (seconds since 1970)
  var iTimeMS   : Int64  = 0 //< milliseconds since 1970 = VscMode start time + self.dwMS
  var fDeltaSec : Float  = 0 //< delta seconds to the previous data in float
  var fAtrHR    : Float  = 0 //< delta seconds to the previous data in float
  
  // for loading from file
  var idx       : Int    = 0
  
  let ATR_TOKEN_ID_IDX              : Int = 0  //< index of csv file
  let ATR_TOKEN_ID_TIME_STR         : Int = 1  //< time string from begining
  let ATR_TOKEN_ID_TIME_SEC         : Int = 2  //< time in float second from begining
  let ATR_TOKEN_ID_DELTA_TIME_SEC   : Int = 3  //< time in float second from begining
  let ATR_TOKEN_ID_ATR_CODE         : Int = 4  //< ATR code Readable name in string
  let ATR_TOKEN_ID_ATR_STR          : Int = 5  //< ATR Readable name in string
  let ATR_TOKEN_ID_ATR_ABBREV       : Int = 6  //< ATR code Readable name in string
  
  let ATR_TOKEN_NUM                 : Int = 7
  
  
  override init()
  {
    super.init()
  }
    
  deinit
  {
  }
  
  func Set(_ bAtr : UInt8, _ dwMS : UInt32)
  {
    self.bAtr    = bAtr
    self.dwMS    = dwMS
    self.iTimeMS = 0
  }
  
  func Set2(_ bAtr : UInt8, _ dwMS : UInt32, _ iStartUTC : Int)
  {
    let iStartUtcMS  : Int64 = Int64(iStartUTC) * 1000
    self.bAtr    = bAtr
    self.dwMS    = dwMS
    self.iTimeMS = iStartUtcMS + Int64(self.dwMS)
  }
  
  func StartTimeSet(_ iStartUTC : Int64)
  {
    let iStartUtcMS  : Int64 = iStartUTC * 1000
    self.iTimeMS = iStartUtcMS + Int64(self.dwMS)
  }
  
  func AtrCopy(_ atr : JAtrType)
  {
    self.bAtr       = atr.bAtr
    self.dwMS       = atr.dwMS
    self.iTimeMS    = atr.iTimeMS
    self.fDeltaSec  = atr.fDeltaSec
    self.fAtrHR     = atr.fAtrHR    
  }
  
  func Reset()
  {
    self.bAtr       = ATR_NONE
    self.dwMS       = 0
    self.iTimeMS    = 0
    self.fDeltaSec  = 0
    self.fAtrHR     = 0
  }
  
  func Parse(_ strLine : String, _ iStartUtcMS : Int64)->Bool
  {
    let tmpArr : [String]? = strLine.components(separatedBy: ",")
    if(tmpArr?.count == 0)
    {
      return FALSE
    }
    let tokenArr: [String] = tmpArr!
    if(tokenArr.count != ATR_TOKEN_NUM)
    {
      print(String(format : "[ATR][ERROR] token != 7 (%d)\n", tokenArr.count))
      print(String(format : "[ATR][ERROR] '%@'", strLine))
      return FALSE
    }
    
    self.idx        = Int(tokenArr[ATR_TOKEN_ID_IDX])!
    self.bAtr       = UInt8(tokenArr[ATR_TOKEN_ID_ATR_CODE])!
    self.dwMS       = UInt32(Float(tokenArr[ATR_TOKEN_ID_TIME_SEC])! * 1000)
    self.fDeltaSec  = Float(tokenArr[ATR_TOKEN_ID_DELTA_TIME_SEC])!
    self.iTimeMS    = iStartUtcMS + Int64(self.dwMS)
    return TRUE
  }
    
  func AtrPrint()
  {
    let fTimeMS : Float64 = Float64(self.iTimeMS) / 1000
    let strMsg : String = String(format :"\t\t [ATR] %f : ATR = '%@', ",             fTimeMS, JAtrLabel[Int(self.bAtr)]) +
                          String(format :"ATR_ABREV = '%@', DELTA_SEC = %0.3f sec",  JAtrAbbrev[Int(self.bAtr)], self.fDeltaSec)
  
    print(strMsg)
  }
}

