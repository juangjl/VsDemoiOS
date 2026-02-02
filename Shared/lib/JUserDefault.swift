//--------------------------------------------------------------------------------
// @file  JUserDefault.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

// 0. INIT
public let JUD_KEY_INIT_TOKEN                       : String = "JUD_KEY_INIT_TOKEN"
public let JUD_VAL_INIT_TOKEN                       : String = "48110164-0042"

// 1. DEVICE_SSN
public let JUD_KEY_DEVICE_SSN                       : String = "JUD_KEY_DEVICE_SSN"
public let JUD_VAL_DEVICE_SSN                       : String = "000-00-0000"

// 2. DEVICE_NAME
public let JUD_KEY_DEVICE_NAME                      : String = "JUD_KEY_DEVICE_NAME"
public let JUD_VAL_DEVICE_NAME                      : String = "VSH101_0001"

// 3. AUTO CONNECT ON
public let JUD_KEY_AUTO_CONNECT_ON                  : String = "JUD_KEY_AUTO_CONNECT_ON"
public let JUD_VAL_AUTO_CONNECT_ON                  : String = "ON"

// 4. AUTO CONNECT_NAME
public let JUD_KEY_AUTO_CONNECT_NAME                : String = "JUD_KEY_AUTO_CONNECT_NAME"
public let JUD_VAL_AUTO_CONNECT_NAME                : String = ""

// 5. AUTO CONNECT STATUS
public let JUD_KEY_AUTO_CONNECT_STATUS              : String = "JUD_KEY_AUTO_CONNECT_STATUS"
public let JUD_VAL_AUTO_CONNECT_STATUS              : String = "OFF"

// 6. AUTO MEASUREMENT STATUS
public let JUD_KEY_AUTO_MEASUREMENT_STATUS          : String = "JUD_KEY_AUTO_MEASUREMENT_STATUS"
public let JUD_VAL_AUTO_MEASUREMENT_STATUS          : String = "OFF"

// 7. AUTO CONNECT SM PAIR ON
public let JUD_KEY_AUTO_CONNECT_SM_PAIR_ON          : String = "JUD_KEY_AUTO_CONNECT_SM_PAIR_ON"
public let JUD_VAL_AUTO_CONNECT_SM_PAIR_ON          : String = "ON"

// 8. ALARM ON
public let JUD_KEY_ALARM_CHECK                      : String = "JUD_KEY_ALARM_CHECK"
public let JUD_VAL_ALARM_CHECK                      : String = "OFF"

// 9. ALARM HR ON
public let JUD_KEY_ALARM_HR_ON                      : String = "JUD_KEY_ALARM_HR_ON"
public let JUD_VAL_ALARM_HR_ON                      : String = "OFF"

// 10. ALARM HR MIN
public let JUD_KEY_ALARM_HR_LOW                     : String = "JUD_KEY_ALARM_HR_LOW"
public let JUD_VAL_ALARM_HR_LOW                     : String = "30.0"

// 11. ALARM HR MAX
public let JUD_KEY_ALARM_HR_HIGH                    : String = "JUD_KEY_ALARM_HR_HIGH"
public let JUD_VAL_ALARM_HR_HIGH                    : String = "120.0"

// 12. ALARM HR HIGH TIMEOUT
public let JUD_KEY_ALARM_HR_TIMEOUT                 : String = "JUD_KEY_ALARM_HR_TIMEOUT"
public let JUD_VAL_ALARM_HR_TIMEOUT                 : String = "5"

// 13. ALARM TEMP ON
public let JUD_KEY_ALARM_TEMP_ON                    : String = "JUD_KEY_ALARM_TEMP_ON"
public let JUD_VAL_ALARM_TEMP_ON                    : String = "OFF"

// 14. ALARM TEMP MIN
public let JUD_KEY_ALARM_TEMP_MIN                   : String = "JUD_KEY_ALARM_TEMP_MIN"
public let JUD_VAL_ALARM_TEMP_MIN                   : String = "34.0"

// 15. ALARM TEMP MAX
public let JUD_KEY_ALARM_TEMP_MAX                   : String = "JUD_KEY_ALARM_TEMP_MAX"
public let JUD_VAL_ALARM_TEMP_MAX                   : String = "36.0"

// 16. ALARM TEMP TIMEOUT
public let JUD_KEY_ALARM_TEMP_TIMEOUT               : String = "JUD_KEY_ALARM_TEMP_TIMEOUT"
public let JUD_VAL_ALARM_TEMP_TIMEOUT               : String = "30"

// 17. ALARM FALLING ON
public let JUD_KEY_ALARM_FALLING_ON                 : String = "JUD_KEY_ALARM_FALLING_ON"
public let JUD_VAL_ALARM_FALLING_ON                 : String = "OFF"

// 18. ALARM FALLING MAX
public let JUD_KEY_ALARM_FALLING_MAX                : String = "JUD_KEY_ALARM_FALLING_MAX"
public let JUD_VAL_ALARM_FALLING_MAX                : String = "4000"

// 19. ALARM FALLING TIME
public let JUD_KEY_ALARM_FALLING_TIME               : String = "JUD_KEY_ALARM_FALLING_TIME"
public let JUD_VAL_ALARM_FALLING_TIME               : String = "0"

// 20. ALARM FALLING EVENT
public let JUD_KEY_ALARM_FALLING_EVENT              : String = "JUD_KEY_ALARM_FALLING_EVENT"
public let JUD_VAL_ALARM_FALLING_EVENT              : String = "OFF"

// 21. ALARM MOTIONLESS ON
public let JUD_KEY_ALARM_MOTIONLESS_ON              : String = "JUD_KEY_ALARM_MOTIONLESS_ON"
public let JUD_VAL_ALARM_MOTIONLESS_ON              : String = "OFF"

// 22. ALARM MOTIONLESS MIN
public let JUD_KEY_ALARM_MOTIONLESS_MIN             : String = "JUD_KEY_ALARM_MOTIONLESS_MIN"
public let JUD_VAL_ALARM_MOTIONLESS_MIN             : String = "800"

// 23. ALARM MOTIONLESS MAX
public let JUD_KEY_ALARM_MOTIONLESS_MAX             : String = "JUD_KEY_ALARM_MOTIONLESS_MAX"
public let JUD_VAL_ALARM_MOTIONLESS_MAX             : String = "4000"

// 24. ALARM MOTIONLESS TIMEOUT
public let JUD_KEY_ALARM_MOTIONLESS_TIMEOUT         : String = "JUD_KEY_ALARM_MOTIONLESS_TIMEOUT"
public let JUD_VAL_ALARM_MOTIONLESS_TIMEOUT         : String = "30"

// 25. ALARM JUD_KEY_ALARM_SOUND_ON
public let JUD_KEY_ALARM_SOUND_ON                   : String = "JUD_KEY_ALARM_SOUND_ON"
public let JUD_VAL_ALARM_SOUND_ON                   : String = "ON"

// 26. RECORD ID
public let JUD_KEY_RECORD_ID                        : String = "JUD_KEY_RECORD_ID"
public let JUD_VAL_RECORD_ID                        : String = "-1"

// 27. MEAS ID
public let JUD_KEY_MEAS_ID                          : String = "JUD_KEY_MEAS_ID"
public let JUD_VAL_MEAS_ID                          : String = "-1"

//------------------------------------------------------------------------------------------------//
// REPORT INFORMATION
//------------------------------------------------------------------------------------------------//
// 28. POINCARE_PLOT_WIDTH  
public let JUD_KEY_POINCARE_PLOT_WIDTH              : String = "JUD_KEY_POINCARE_PLOT_WIDTH"
public let JUD_VAL_POINCARE_PLOT_WIDTH              : String = "1500"

// 29. CLINIC_INFO_SHOW
public let JUD_KEY_CLINIC_INFO_SHOW_ON              : String = "JUD_KEY_CLINIC_INFO_SHOW_ON"
public let JUD_VAL_CLINIC_INFO_SHOW_ON              : String = "ON"

// 30. INSTITUTION_INFO_SHOW 
public let JUD_KEY_INSTITUTION_INFO_SHOW_ON         : String = "JUD_KEY_INSTITUTION_INFO_SHOW_ON"
public let JUD_VAL_INSTITUTION_INFO_SHOW_ON         : String = "ON"

// 31. PATIENT_SSN
public let JUD_KEY_PATIENT_SSN                      : String = "JUD_KEY_PATIENT_SSN"
public let JUD_VAL_PATIENT_SSN                      : String = "A123456789"

// 32. CLINIC_PHONE
public let JUD_KEY_CLINIC_PHONE                     : String = "JUD_KEY_CLINIC_PHONE"
public let JUD_VAL_CLINIC_PHONE                     : String = "+886-36682091"

// 33. PATIENT_PRIMARY_INDICATION
public let JUD_KEY_PATIENT_PRIMARY_INDICATION       : String = "JUD_KEY_PATIENT_PRIMARY_INDICATION"
public let JUD_VAL_PATIENT_PRIMARY_INDICATION       : String = "Cardiac arrhythmia"

// 34. CLINICIAN_NAME
public let JUD_KEY_CLINICIAN_NAME                   : String = "JUD_KEY_CLINICIAN_NAME"
public let JUD_VAL_CLINICIAN_NAME                   : String = "Kevin"

// 35. CLINIC_ADDR
public let JUD_KEY_CLINIC_ADDRESS                   : String = "JUD_KEY_CLINIC_ADDRESS"
public let JUD_VAL_CLINIC_ADDR                      : String = "--"

// 36. CLINIC_NAME
public let JUD_KEY_CLINIC_NAME                      : String = "JUD_KEY_CLINIC_NAME"
public let JUD_VAL_CLINIC_NAME                      : String = "Hospital of Taiwan University"

// 37. INSTITUTION_NAME
public let JUD_KEY_INSTITUTION_NAME                 : String = "JUD_KEY_INSTITUTION_NAME"
public let JUD_VAL_INSTITUTION_NAME                 : String = "VitalSigns Technology"

// 38. INSTITUTION_TEL
public let JUD_KEY_INSTITUTION_TEL                  : String = "JUD_KEY_INSTITUTION_TEL"
public let JUD_VAL_INSTITUTION_TEL                  : String = "+886-3-6682091"

// 39. INSTITUTION_WEBSITE
public let JUD_KEY_INSTITUTION_WEBSITE              : String = "JUD_KEY_INSTITUTION_WEBSITE"
public let JUD_VAL_INSTITUTION_WEBSITE              : String = "https://www.vsigntek.com"

//------------------------------------------------------------------------------------------------//
// Database
//------------------------------------------------------------------------------------------------//
// 40. Database Name
public let JUD_KEY_DB_VERSION                       : String = "JUD_KEY_DB_VERSION"
public let JUD_VAL_DB_VERSION                       : String = "2"

//------------------------------------------------------------------------------------------------//
// Database
//------------------------------------------------------------------------------------------------//
// 41. Dictionary
public let JUD_KEY_DICT_TYPE                        : String = "JUD_KEY_DICT_TYPE"
public let JUD_VAL_DICT_TYPE                        : String = "-1"

//------------------------------------------------------------------------------------------------//
// View conrol
//------------------------------------------------------------------------------------------------//
// 42. VIEW_STATIC_GSENSOR
public let JUD_KEY_VIEW_STATISTIC_GSENSOR           : String = "JUD_KEY_VIEW_STATISTIC_GSENSOR"
public let JUD_VAL_VIEW_STATISTIC_GSENSOR           : String = "1"

// 43. VIEW_STATIC_HRV
public let JUD_KEY_VIEW_STATISTIC_HRV               : String = "JUD_KEY_VIEW_STATISTIC_HRV"
public let JUD_VAL_VIEW_STATISTIC_HRV               : String = "1"

//------------------------------------------------------------------------------------------------//
// Report
//------------------------------------------------------------------------------------------------//
// 44. REPORT_ON
public let JUD_KEY_REPORT_ON                        : String = "JUD_KEY_REPORT_ON"
public let JUD_VAL_REPORT_ON                        : String = "OFF"

// 45. MEASUREMENT_PERIOD
public let JUD_KEY_MEASUREMENT_PERIOD               : String = "JUD_KEY_MEASUREMENT_PERIOD"
public let JUD_VAL_MEASUREMENT_PERIOD               : String = "0"

//------------------------------------------------------------------------------------------------//
// SOFTWARE FILTER
//------------------------------------------------------------------------------------------------//
// 46. SOFT_FILTER_ENABLE
public let JUD_KEY_SOFT_FILTER_ENABLE               : String = "JUD_KEY_SOFT_FILTER_ENABLE"
public let JUD_VAL_SOFT_FILTER_ENABLE               : String = "OFF"

// 47. SOFT_50HZ_NOTCH_FILTER_ENABLE
public let JUD_KEY_SOFT_50HZ_NOTCH_FILTER_ENABLE    : String = "JUD_KEY_SOFT_50HZ_NOTCH_FILTER_ENABLE"
public let JUD_VAL_SOFT_50HZ_NOTCH_FILTER_ENABLE    : String = "OFF"

// 48. SOFT_60HZ_NOTCH_FILTER_ENABLE
public let JUD_KEY_SOFT_60HZ_NOTCH_FILTER_ENABLE    : String = "JUD_KEY_SOFT_60HZ_NOTCH_FILTER_ENABLE"
public let JUD_VAL_SOFT_60HZ_NOTCH_FILTER_ENABLE    : String = "OFF"

// 49. SOFT_1ST_LPF_FILTER_ENABLE
public let JUD_KEY_SOFT_1ST_LPF_FILTER_ENABLE       : String = "JUD_KEY_SOFT_1ST_LPF_FILTER_ENABLE"
public let JUD_VAL_SOFT_1ST_LPF_FILTER_ENABLE       : String = "OFF"

// 50. SOFT_1ST_HPF_FILTER_ENABLE
public let JUD_KEY_SOFT_1ST_HPF_FILTER_ENABLE       : String = "JUD_KEY_SOFT_1ST_HPF_FILTER_ENABLE"
public let JUD_VAL_SOFT_1ST_HPF_FILTER_ENABLE       : String = "OFF"

// 51. SOFT_2ND_LPF_FILTER_ENABLE
public let JUD_KEY_SOFT_2ND_LPF_FILTER_ENABLE       : String = "JUD_KEY_SOFT_2ND_LPF_FILTER_ENABLE"
public let JUD_VAL_SOFT_2ND_LPF_FILTER_ENABLE       : String = "OFF"

// 52. SOFT_2ND_HPF_FILTER_ENABLE
public let JUD_KEY_SOFT_2ND_HPF_FILTER_ENABLE       : String = "JUD_KEY_SOFT_2ND_HPF_FILTER_ENABLE"
public let JUD_VAL_SOFT_2ND_HPF_FILTER_ENABLE       : String = "OFF"

// 53. SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ
public let JUD_KEY_SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ : String = "JUD_KEY_SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ"
public let JUD_VAL_SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ : String = "47"

// 54. SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ
public let JUD_KEY_SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ : String = "JUD_KEY_SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ"
public let JUD_VAL_SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ : String = "0.05"

// 55. SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ
public let JUD_KEY_SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ : String = "JUD_KEY_SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ"
public let JUD_VAL_SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ : String = "47"

// 56. SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ
public let JUD_KEY_SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ : String = "JUD_KEY_SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ"
public let JUD_VAL_SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ : String = "0.05"

// 57. SOFT_1ST_LPF_FILTER_Q
public let JUD_KEY_SOFT_1ST_LPF_FILTER_Q            : String = "JUD_KEY_SOFT_1ST_LPF_FILTER_Q"
public let JUD_VAL_SOFT_1ST_LPF_FILTER_Q            : String = "1"

// 58. SOFT_1ST_LPF_FILTER_DB
public let JUD_KEY_SOFT_1ST_LPF_FILTER_DB           : String = "JUD_KEY_SOFT_1ST_LPF_FILTER_DB"
public let JUD_VAL_SOFT_1ST_LPF_FILTER_DB           : String = "6"

// 59. SOFT_1ST_HPF_FILTER_Q
public let JUD_KEY_SOFT_1ST_HPF_FILTER_Q            : String = "JUD_KEY_SOFT_1ST_HPF_FILTER_Q"
public let JUD_VAL_SOFT_1ST_HPF_FILTER_Q            : String = "1"

// 60. SOFT_1ST_HPF_FILTER_DB
public let JUD_KEY_SOFT_1ST_HPF_FILTER_DB           : String = "JUD_KEY_SOFT_1ST_HPF_FILTER_DB"
public let JUD_VAL_SOFT_1ST_HPF_FILTER_DB           : String = "6"

// 61. SOFT_2ND_LPF_FILTER_Q
public let JUD_KEY_SOFT_2ND_LPF_FILTER_Q            : String = "JUD_KEY_SOFT_2ND_LPF_FILTER_Q"
public let JUD_VAL_SOFT_2ND_LPF_FILTER_Q            : String = "1"

// 62. SOFT_2ND_LPF_FILTER_DB
public let JUD_KEY_SOFT_2ND_LPF_FILTER_DB           : String = "JUD_KEY_SOFT_2ND_LPF_FILTER_DB"
public let JUD_VAL_SOFT_2ND_LPF_FILTER_DB           : String = "6"

// 63. SOFT_2ND_HPF_FILTER_Q
public let JUD_KEY_SOFT_2ND_HPF_FILTER_Q            : String = "JUD_KEY_SOFT_2ND_HPF_FILTER_Q"
public let JUD_VAL_SOFT_2ND_HPF_FILTER_Q            : String = "1"

// 64. SOFT_2ND_HPF_FILTER_DB
public let JUD_KEY_SOFT_2ND_HPF_FILTER_DB           : String = "JUD_KEY_SOFT_2ND_HPF_FILTER_DB"
public let JUD_VAL_SOFT_2ND_HPF_FILTER_DB           : String = "6"

// 65. SOFT_50_NOTCH_FILTER_Q
public let JUD_KEY_SOFT_50_NOTCH_FILTER_Q            : String = "JUD_KEY_SOFT_50_NOTCH_FILTER_Q"
public let JUD_VAL_SOFT_50_NOTCH_FILTER_Q            : String = "6"

// 66. SOFT_50_NOTCH_FILTER_DB
public let JUD_KEY_SOFT_50_NOTCH_FILTER_DB           : String = "JUD_KEY_SOFT_50_NOTCH_FILTER_DB"
public let JUD_VAL_SOFT_50_NOTCH_FILTER_DB           : String = "6"

// 67. SOFT_60_NOTCH_FILTER_Q
public let JUD_KEY_SOFT_60_NOTCH_FILTER_Q            : String = "JUD_KEY_SOFT_60_NOTCH_FILTER_Q"
public let JUD_VAL_SOFT_60_NOTCH_FILTER_Q            : String = "6"

// 68. SOFT_60_NOTCH_FILTER_DB
public let JUD_KEY_SOFT_60_NOTCH_FILTER_DB           : String = "JUD_KEY_SOFT_60_NOTCH_FILTER_DB"
public let JUD_VAL_SOFT_60_NOTCH_FILTER_DB           : String = "6"

//------------------------------------------------------------------------------------------------//
// Disclaimer
//------------------------------------------------------------------------------------------------//
// 69. Disclaimer
public let JUD_KEY_DISCLAIMER_ID                    : String = "JUD_KEY_DISCLAIMER_ID"
public let JUD_VAL_DISCLAIMER_ID                    : String = "ON"

//------------------------------------------------------------------------------------------------//
// Map
//------------------------------------------------------------------------------------------------//
// 70. MAP
public let JUD_KEY_VIEW_MEASUREMENT_MAP_ID          : String = "JUD_KEY_VIEW_MEASUREMENT_MAP_ID"
public let JUD_VAL_VIEW_MEASUREMENT_MAP_ID          : String = "OFF"

//------------------------------------------------------------------------------------------------//
// Pin Code
//------------------------------------------------------------------------------------------------//
// 71. Pin Code
public let JUD_KEY_DEVICE_PIN_CODE                  : String = "JUD_KEY_DEVICE_PIN_CODE"
public let JUD_VAL_DEVICE_PIN_CODE                  : String = "1234"

//------------------------------------------------------------------------------------------------//
// VSC File Mode
//------------------------------------------------------------------------------------------------//
// 72. VSC File Mode
public let JUD_KEY_VSC_FILE_MODE                    : String = "JUD_KEY_VSC_FILE_MODE"
public let JUD_VAL_VSC_FILE_MODE                    : String = "ON"

// 73. JUD_KEY_VSC_FILE_MODE_PERIOD
public let JUD_KEY_VSC_FILE_MODE_PERIOD             : String = "JUD_KEY_VSC_FILE_MODE_PERIOD"
public let JUD_VAL_VSC_FILE_MODE_PERIOD             : String = "0"

//------------------------------------------------------------------------------------------------//
// PACKET ERROR
//------------------------------------------------------------------------------------------------//
// 74. JUD_KEY_PACKET_ERROR_RATE_ON
public let JUD_KEY_PACKET_ERROR_RATE_ON             : String = "JUD_KEY_PACKET_ERROR_RATE_ON"
public let JUD_VAL_PACKET_ERROR_RATE_ON             : String = "OFF"

// 75. JUD_KEY_PACKET_ERROR_RATE_START
public let JUD_KEY_PACKET_ERROR_RATE_START          : String = "JUD_KEY_PACKET_ERROR_RATE_START"
public let JUD_VAL_PACKET_ERROR_RATE_START          : String = "OFF"

//------------------------------------------------------------------------------------------------//
// ECG CHART GRID
//------------------------------------------------------------------------------------------------//
// 76. JUD_KEY_ECG_CHART_ROW_COUNT
public let JUD_KEY_ECG_CHART_ROW_COUNT              : String = "JUD_KEY_ECG_CHART_ROW_COUNT"
public let JUD_VAL_ECG_CHART_ROW_COUNT              : String = "12"

//------------------------------------------------------------------------------------------------//
// PRELIMINARY_FINDINGS_SHOW_ON
//------------------------------------------------------------------------------------------------//
// 77. CLINIC_INFO_SHOW
public let JUD_KEY_PRELIMINARY_FINDINGS_SHOW_ON      : String = "JUD_KEY_PRELIMINARY_FINDINGS_SHOW_ON"
public let JUD_VAL_PRELIMINARY_FINDINGS_SHOW_ON      : String = "ON"

//------------------------------------------------------------------------------------------------//
// FINALINTERPRETATION_SHOW_ON
//------------------------------------------------------------------------------------------------//
// 78. CLINIC_INFO_SHOW
public let JUD_KEY_FINAL_INTERPRETATION_SHOW_ON      : String = "JUD_KEY_FINAL_INTERPRETATION_SHOW_ON"
public let JUD_VAL_FINAL_INTERPRETATION_SHOW_ON      : String = "ON"

//------------------------------------------------------------------------------------------------//
//  TEST
//------------------------------------------------------------------------------------------------//
// 79. TEST_MAIN_KEY
public let JUD_KEY_TEST_MAIN_KEY                     : String = "JUD_KEY_TEST_KEY"
public let JUD_VAL_TEST_MAIN_KEY                     : String = "12458157568997741552563365478232" //< shall be with a lengh of 32 bytes                                                     

//------------------------------------------------------------------------------------------------//
//  REPORT JSON
//------------------------------------------------------------------------------------------------//
// 80. REPORT_JSON_PLAIN_FILE_SAVE_ON
public let JUD_KEY_REPORT_JSON_PLAIN_FILE_SAVE_ON    : String = "JUD_KEY_REPORT_JSON_PLAIN_FILE_SAVE_ON"
public let JUD_VAL_REPORT_JSON_PLAIN_FILE_SAVE_ON    : String = "ON"

//------------------------------------------------------------------------------------------------//
//  REPORT PDF
//------------------------------------------------------------------------------------------------//
// 81. REPORT_PDF_PLAIN_FILE_SAVE_ON
public let JUD_KEY_REPORT_PDF_PLAIN_FILE_SAVE_ON    : String = "JUD_KEY_REPORT_PDF_PLAIN_FILE_SAVE_ON"
public let JUD_VAL_REPORT_PDF_PLAIN_FILE_SAVE_ON    : String = "ON"

//------------------------------------------------------------------------------------------------//
//  DATABASE_ENCRYPTION_ON
//------------------------------------------------------------------------------------------------//
// 82. DATABASE_ENCRYPTION_ON
public let JUD_KEY_DATABASE_ENCRYPTION_ON           : String = "JUD_KEY_DATABASE_ENCRYPTION_ON"
public let JUD_VAL_DATABASE_ENCRYPTION_ON           : String = "ON"

//------------------------------------------------------------------------------------------------//
//  ALARM FALLING EVENT TIME
//------------------------------------------------------------------------------------------------//
// 83. ALARM FALLING EVENT TIME
public let JUD_KEY_ALARM_FALLING_EVENT_TIME         : String = "JUD_KEY_ALARM_FALLING_EVENT_TIME"
public let JUD_VAL_ALARM_FALLING_EVENT_TIME         : String = ""

// 84. ALARM MOTIONLESS EVENT TIME
public let JUD_KEY_ALARM_MOTIONLESS_EVENT_TIME      : String = "JUD_KEY_ALARM_MOTIONLESS_EVENT_TIME"
public let JUD_VAL_ALARM_MOTIONLESS_EVENT_TIME      : String = ""

//------------------------------------------------------------------------------------------------//
//  USER LOGIN FUNCTION
//------------------------------------------------------------------------------------------------//
// 85. JUD_KEY_USER_LOGIN_EMAIL
public let JUD_KEY_USER_LOGIN_EMAIL                 : String = "JUD_KEY_USER_LOGIN_EMAIL"
public let JUD_VAL_USER_LOGIN_EMAIL                 : String = ""

// 86. USER_LOGIN_PASSWORD
public let JUD_KEY_USER_LOGIN_PASSWORD              : String = "JUD_KEY_USER_LOGIN_PASSWORD"
public let JUD_VAL_USER_LOGIN_PASSWORD              : String = ""

// 87. USER_LOGIN_API_SESSION
public let JUD_KEY_USER_LOGIN_API_SESSION           : String = "JUD_KEY_USER_LOGIN_API_SESSION"
public let JUD_VAL_USER_LOGIN_API_SESSION           : String = ""

//--------------------------------------------------------------------------------------------------------//
//
// JUD : User Default Value Control Class
//
//--------------------------------------------------------------------------------------------------------//
class JUserDefault
{
  let userDefaults = UserDefaults.standard
  var bAtr    : UInt8  = 0
  
  var defaultKey : [String] = [
                                JUD_KEY_INIT_TOKEN,                             //< 00
                                JUD_KEY_DEVICE_SSN,                             //< 01
                                JUD_KEY_DEVICE_NAME,                            //< 02
                                JUD_KEY_AUTO_CONNECT_ON,                        //< 03
                                JUD_KEY_AUTO_CONNECT_NAME,                      //< 04
                                JUD_KEY_AUTO_CONNECT_STATUS,                    //< 05                                
                                JUD_KEY_AUTO_MEASUREMENT_STATUS,                //< 06
                                JUD_KEY_AUTO_CONNECT_SM_PAIR_ON,                //< 07

                                JUD_KEY_ALARM_CHECK,                            //< 08
                                JUD_KEY_ALARM_HR_ON,                            //< 09
                                JUD_KEY_ALARM_HR_LOW,                           //< 10
                                JUD_KEY_ALARM_HR_HIGH,                          //< 11
                                JUD_KEY_ALARM_HR_TIMEOUT,                       //< 12                                
                                JUD_KEY_ALARM_TEMP_ON,                          //< 13
                                JUD_KEY_ALARM_TEMP_MIN,                         //< 14
                                JUD_KEY_ALARM_TEMP_MAX,                         //< 15
                                JUD_KEY_ALARM_TEMP_TIMEOUT,                     //< 16
                                JUD_KEY_ALARM_FALLING_ON,                       //< 17
                                JUD_KEY_ALARM_FALLING_MAX,                      //< 18
                                JUD_KEY_ALARM_FALLING_TIME,                     //< 19
                                JUD_KEY_ALARM_FALLING_EVENT,                    //< 20
                                JUD_KEY_ALARM_MOTIONLESS_ON,                    //< 21
                                JUD_KEY_ALARM_MOTIONLESS_MIN,                   //< 22
                                JUD_KEY_ALARM_MOTIONLESS_MAX,                   //< 23
                                JUD_KEY_ALARM_MOTIONLESS_TIMEOUT,               //< 24
                                JUD_KEY_ALARM_SOUND_ON,                         //< 25
                                JUD_KEY_RECORD_ID,                              //< 26
                                JUD_KEY_MEAS_ID,                                //< 27
                                JUD_KEY_POINCARE_PLOT_WIDTH,                    //< 28
                                JUD_KEY_CLINIC_INFO_SHOW_ON,                    //< 29
                                JUD_KEY_INSTITUTION_INFO_SHOW_ON,               //< 30
                                JUD_KEY_PATIENT_SSN,                            //< 31
                                JUD_KEY_CLINIC_PHONE,                           //< 32
                                JUD_KEY_PATIENT_PRIMARY_INDICATION,             //< 33
                                JUD_KEY_CLINICIAN_NAME,                         //< 34
                                JUD_KEY_CLINIC_ADDRESS,                         //< 35
                                JUD_KEY_CLINIC_NAME,                            //< 36
                                JUD_KEY_INSTITUTION_NAME,                       //< 37
                                JUD_KEY_INSTITUTION_TEL,                        //< 38
                                JUD_KEY_INSTITUTION_WEBSITE,                    //< 39
                                JUD_KEY_DB_VERSION,                             //< 40
                                JUD_KEY_DICT_TYPE,                              //< 41
                                JUD_KEY_VIEW_STATISTIC_GSENSOR,                 //< 42
                                JUD_KEY_VIEW_STATISTIC_HRV,                     //< 43
                                JUD_KEY_REPORT_ON,                              //< 44
                                JUD_KEY_MEASUREMENT_PERIOD,                     //< 45
                                JUD_KEY_SOFT_FILTER_ENABLE,                     //< 46
                                JUD_KEY_SOFT_50HZ_NOTCH_FILTER_ENABLE,          //< 47
                                JUD_KEY_SOFT_60HZ_NOTCH_FILTER_ENABLE,          //< 48
                                JUD_KEY_SOFT_1ST_LPF_FILTER_ENABLE,             //< 49
                                JUD_KEY_SOFT_1ST_HPF_FILTER_ENABLE,             //< 50
                                JUD_KEY_SOFT_2ND_LPF_FILTER_ENABLE,             //< 51
                                JUD_KEY_SOFT_2ND_HPF_FILTER_ENABLE,             //< 52
                                JUD_KEY_SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ,       //< 53
                                JUD_KEY_SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ,       //< 54
                                JUD_KEY_SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ,       //< 55
                                JUD_KEY_SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ,       //< 56
                                JUD_KEY_SOFT_1ST_LPF_FILTER_Q,                  //< 57
                                JUD_KEY_SOFT_1ST_LPF_FILTER_DB,                 //< 58
                                JUD_KEY_SOFT_1ST_HPF_FILTER_Q,                  //< 59
                                JUD_KEY_SOFT_1ST_HPF_FILTER_DB,                 //< 60
                                JUD_KEY_SOFT_2ND_LPF_FILTER_Q,                  //< 61
                                JUD_KEY_SOFT_2ND_LPF_FILTER_DB,                 //< 62
                                JUD_KEY_SOFT_2ND_HPF_FILTER_Q,                  //< 63
                                JUD_KEY_SOFT_2ND_HPF_FILTER_DB,                 //< 64
                                JUD_KEY_SOFT_50_NOTCH_FILTER_Q,                 //< 65
                                JUD_KEY_SOFT_50_NOTCH_FILTER_DB,                //< 66
                                JUD_KEY_SOFT_60_NOTCH_FILTER_Q,                 //< 67
                                JUD_KEY_SOFT_60_NOTCH_FILTER_DB,                //< 68
                                JUD_KEY_VIEW_MEASUREMENT_MAP_ID,                //< 69
                                JUD_KEY_DISCLAIMER_ID,                          //< 70
                                JUD_KEY_DEVICE_PIN_CODE,                        //< 71
                                JUD_KEY_VSC_FILE_MODE,                          //< 72
                                JUD_KEY_VSC_FILE_MODE_PERIOD,                   //< 73
                                JUD_KEY_PACKET_ERROR_RATE_ON,                   //< 74    
                                JUD_KEY_PACKET_ERROR_RATE_START,                //< 75
                                JUD_KEY_ECG_CHART_ROW_COUNT,                    //< 76  
                                JUD_KEY_PRELIMINARY_FINDINGS_SHOW_ON,           //< 77 
                                JUD_KEY_FINAL_INTERPRETATION_SHOW_ON,           //< 78
                                JUD_KEY_TEST_MAIN_KEY,                          //< 79
                                JUD_KEY_REPORT_JSON_PLAIN_FILE_SAVE_ON,         //< 80
                                JUD_KEY_REPORT_PDF_PLAIN_FILE_SAVE_ON,          //< 81
                                JUD_KEY_DATABASE_ENCRYPTION_ON,                 //< 82
                                JUD_KEY_ALARM_FALLING_EVENT_TIME,               //< 83
                                JUD_KEY_ALARM_MOTIONLESS_EVENT_TIME,            //< 84

                                JUD_KEY_USER_LOGIN_EMAIL,                       //< 85
                                JUD_KEY_USER_LOGIN_PASSWORD,                    //< 86
                                JUD_KEY_USER_LOGIN_API_SESSION,                 //< 87
                              ]
  
  var defaultValue : [String] = [
                                JUD_VAL_INIT_TOKEN,                             //< 00
                                JUD_VAL_DEVICE_SSN,                             //< 01
                                JUD_VAL_DEVICE_NAME,                            //< 02
                                JUD_VAL_AUTO_CONNECT_ON,                        //< 03
                                JUD_VAL_AUTO_CONNECT_NAME,                      //< 04
                                JUD_VAL_AUTO_CONNECT_STATUS,                    //< 05
                                JUD_VAL_AUTO_MEASUREMENT_STATUS,                //< 06
                                JUD_VAL_AUTO_CONNECT_SM_PAIR_ON,                //< 07
                                JUD_VAL_ALARM_CHECK,                            //< 08
                                JUD_VAL_ALARM_HR_ON,                            //< 09
                                JUD_VAL_ALARM_HR_LOW,                           //< 10
                                JUD_VAL_ALARM_HR_HIGH,                          //< 11
                                JUD_VAL_ALARM_HR_TIMEOUT,                       //< 12                                
                                JUD_VAL_ALARM_TEMP_ON,                          //< 13
                                JUD_VAL_ALARM_TEMP_MIN,                         //< 14
                                JUD_VAL_ALARM_TEMP_MAX,                         //< 15
                                JUD_VAL_ALARM_TEMP_TIMEOUT,                     //< 16
                                JUD_VAL_ALARM_FALLING_ON,                       //< 17
                                JUD_VAL_ALARM_FALLING_MAX,                      //< 18
                                JUD_VAL_ALARM_FALLING_TIME,                     //< 19
                                JUD_VAL_ALARM_FALLING_EVENT,                    //< 20
                                JUD_VAL_ALARM_MOTIONLESS_ON,                    //< 21
                                JUD_VAL_ALARM_MOTIONLESS_MIN,                   //< 22
                                JUD_VAL_ALARM_MOTIONLESS_MAX,                   //< 23
                                JUD_VAL_ALARM_MOTIONLESS_TIMEOUT,               //< 24
                                JUD_VAL_ALARM_SOUND_ON,                         //< 25
                                JUD_VAL_RECORD_ID,                              //< 26
                                JUD_VAL_MEAS_ID,                                //< 27
                                JUD_VAL_POINCARE_PLOT_WIDTH,                    //< 28
                                JUD_VAL_CLINIC_INFO_SHOW_ON,                    //< 29
                                JUD_VAL_INSTITUTION_INFO_SHOW_ON,               //< 30
                                JUD_VAL_PATIENT_SSN,                            //< 31
                                JUD_VAL_CLINIC_PHONE,                           //< 32
                                JUD_VAL_PATIENT_PRIMARY_INDICATION,             //< 33
                                JUD_VAL_CLINICIAN_NAME,                         //< 34
                                JUD_VAL_CLINIC_ADDR,                            //< 35
                                JUD_VAL_CLINIC_NAME,                            //< 36
                                JUD_VAL_INSTITUTION_NAME,                       //< 37
                                JUD_VAL_INSTITUTION_TEL,                        //< 38
                                JUD_VAL_INSTITUTION_WEBSITE,                    //< 39
                                JUD_VAL_DB_VERSION,                             //< 40
                                JUD_VAL_DICT_TYPE,                              //< 41
                                JUD_VAL_VIEW_STATISTIC_GSENSOR,                 //< 42
                                JUD_VAL_VIEW_STATISTIC_HRV,                     //< 43
                                JUD_VAL_REPORT_ON,                              //< 44
                                JUD_VAL_MEASUREMENT_PERIOD,                     //< 45
                                JUD_VAL_SOFT_FILTER_ENABLE,                     //< 46
                                JUD_VAL_SOFT_50HZ_NOTCH_FILTER_ENABLE,          //< 47
                                JUD_VAL_SOFT_60HZ_NOTCH_FILTER_ENABLE,          //< 48
                                JUD_VAL_SOFT_1ST_LPF_FILTER_ENABLE,             //< 49
                                JUD_VAL_SOFT_1ST_HPF_FILTER_ENABLE,             //< 50
                                JUD_VAL_SOFT_2ND_LPF_FILTER_ENABLE,             //< 51
                                JUD_VAL_SOFT_2ND_HPF_FILTER_ENABLE,             //< 52
                                JUD_VAL_SOFT_1ST_LPF_FILTER_CUT_OFF_FREQ,       //< 53
                                JUD_VAL_SOFT_1ST_HPF_FILTER_CUT_OFF_FREQ,       //< 54
                                JUD_VAL_SOFT_2ND_LPF_FILTER_CUT_OFF_FREQ,       //< 55
                                JUD_VAL_SOFT_2ND_HPF_FILTER_CUT_OFF_FREQ,       //< 56
                                JUD_VAL_SOFT_1ST_LPF_FILTER_Q,                  //< 57
                                JUD_VAL_SOFT_1ST_LPF_FILTER_DB,                 //< 58
                                JUD_VAL_SOFT_1ST_HPF_FILTER_Q,                  //< 59
                                JUD_VAL_SOFT_1ST_HPF_FILTER_DB,                 //< 60
                                JUD_VAL_SOFT_2ND_LPF_FILTER_Q,                  //< 61
                                JUD_VAL_SOFT_2ND_LPF_FILTER_DB,                 //< 62
                                JUD_VAL_SOFT_2ND_HPF_FILTER_Q,                  //< 63
                                JUD_VAL_SOFT_2ND_HPF_FILTER_DB,                 //< 64
                                JUD_VAL_SOFT_50_NOTCH_FILTER_Q,                 //< 65
                                JUD_VAL_SOFT_50_NOTCH_FILTER_DB,                //< 66
                                JUD_VAL_SOFT_60_NOTCH_FILTER_Q,                 //< 67
                                JUD_VAL_SOFT_60_NOTCH_FILTER_DB,                //< 68
                                JUD_VAL_VIEW_MEASUREMENT_MAP_ID,                //< 69
                                JUD_VAL_DISCLAIMER_ID,                          //< 70
                                JUD_VAL_DEVICE_PIN_CODE,                        //< 71
                                JUD_VAL_VSC_FILE_MODE,                          //< 72
                                JUD_VAL_VSC_FILE_MODE_PERIOD,                   //< 73
                                JUD_VAL_PACKET_ERROR_RATE_ON,                   //< 74  
                                JUD_VAL_PACKET_ERROR_RATE_START,                //< 75
                                JUD_VAL_ECG_CHART_ROW_COUNT,                    //< 76
                                JUD_VAL_PRELIMINARY_FINDINGS_SHOW_ON,           //< 77
                                JUD_VAL_FINAL_INTERPRETATION_SHOW_ON,           //< 78
                                JUD_VAL_TEST_MAIN_KEY,                          //< 79
                                JUD_VAL_REPORT_JSON_PLAIN_FILE_SAVE_ON,         //< 80
                                JUD_VAL_REPORT_PDF_PLAIN_FILE_SAVE_ON,          //< 81
                                JUD_VAL_DATABASE_ENCRYPTION_ON,                 //< 82
                                JUD_VAL_ALARM_FALLING_EVENT_TIME,               //< 83
                                JUD_VAL_ALARM_MOTIONLESS_EVENT_TIME,            //< 84

                                JUD_VAL_USER_LOGIN_EMAIL,                       //< 85
                                JUD_VAL_USER_LOGIN_PASSWORD,                    //< 86
                                JUD_VAL_USER_LOGIN_API_SESSION,                 //< 87
                              ]
  
  init()
  {
    
  }
    
  deinit
  {
  }
  
  func JUDInit()
  {
    if(self.KeyExisted(strKey: JUD_KEY_INIT_TOKEN) == FALSE)
    {
      print(String(format : "[DEFAULT][INIT] Key %@ not existed\n", JUD_KEY_INIT_TOKEN))
      self.Reset()
    }
    else
    {
      let strValue = self.StringGet(JUD_KEY_INIT_TOKEN)
      if(strValue != JUD_VAL_INIT_TOKEN)
      {
        self.Reset()
      }
      //
      self.ReadAll()
    }        
  }
  
  func KeyExisted(strKey : String) -> Bool
  {
    if(self.userDefaults.object(forKey:strKey) == nil)
    {
     return FALSE
    }
    return TRUE
  }
  
  func Set(strKey : String, strValue: String)
  {
    self.userDefaults.set(strValue, forKey : strKey)
  }
  
  func StringGet(_ strKey : String) -> String
  {
    var strValue : String? = ""
    if(self.userDefaults.object(forKey: strKey) != nil)
    {
      strValue = userDefaults.string(forKey: strKey)
    }
    
    return strValue!
  }
  
  func StringSet(_ strKey : String, _ strValue: String)
  {    
    self.userDefaults.set(strValue, forKey : strKey)
  }
  
  func FloatGet(_ strKey : String) -> Float
  {
    var strValue : String? = ""
    var fValue : Float = 0
    if(self.userDefaults.object(forKey: strKey) != nil)
    {
      strValue = userDefaults.string(forKey: strKey)
      
      fValue = (strValue! as NSString).floatValue
    }
    
    return fValue
  }
  
  func FloatSet(_ strKey : String, _ fValue: Float)
  {
    let strValue = String(format : "%f", fValue)
    self.userDefaults.set(strValue, forKey : strKey)
  }
  
  func IntGet(_ strKey : String) -> Int
  {
    var strValue : String? = ""
    var iValue : Int = 0
    if(self.userDefaults.object(forKey: strKey) != nil)
    {
      strValue = userDefaults.string(forKey: strKey)
      
      iValue = (strValue! as NSString).integerValue
    }
    
    return iValue
  }
  
  func IntSet(_ strKey : String, _ iValue: Int)
  {
    let strValue = String(format : "%d", iValue)
    self.userDefaults.set(strValue, forKey : strKey)
  }
    
  func OnGet(_ strKey : String) -> Bool
  {
    var bOn : Bool = FALSE
    var strValue : String? = ""
    
    if(self.userDefaults.object(forKey: strKey) != nil)
    {
      strValue = userDefaults.string(forKey: strKey)
      if(strValue! == "ON")
      {
        bOn = TRUE
      }
      else
      {
        bOn = FALSE
      }
    }
    return bOn
  }
  
  func OnSet(_ strKey : String, _ bValue: Bool)
  {
    var strValue : String = "OFF"
    if(bValue == TRUE)
    {
      strValue = "ON"
    }
    self.userDefaults.set(strValue, forKey : strKey)
  }
  
  func Reset()
  {
    for i in 0..<self.defaultKey.count
    {
      let strKey = self.defaultKey[i]
      let strVal = self.defaultValue[i]
      self.StringSet(strKey, strVal)
    }
    self.JUDPrintAll()
  }
   
  func ReadAll()
  {
    for i in 0..<self.defaultKey.count
    {
      let strKey = self.defaultKey[i]
      self.defaultValue[i] = self.StringGet(strKey)
    }
  }
  
  func JUDPrintAll()
  {
    print(String(format : "%@", "\t\t ------------------------------------------------"))
    for i in 0..<self.defaultKey.count
    {
      let strKey = self.defaultKey[i]
      let strVal = self.defaultValue[i]
      
      let strMsg = String(format : "\t\t [JUD][%02d] ", i) +
                   String(format : "%@ = '%@'", strKey, strVal)
      print(strMsg)
    }
    print(String(format : "%@", "\t\t ------------------------------------------------"))
  }
}
