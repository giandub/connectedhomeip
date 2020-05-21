
/**
 *
 *    Copyright (c) 2020 Project CHIP Authors
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

/**
 *    @file
 *      This file provides command ids that are normally generated by the
 *      ZCL Advanced Platform (ZAP) generator for use in the CHIP ZCL
 *      Application Layer. These declarations are provided here for the
 *      purposes of unit testing the CHIP ZCL Application Layer
 *
 */

// Enclosing macro to prevent multiple inclusion
#ifndef CHIP_ZCL_GEN_COMMAND_ID_HEADER
#define CHIP_ZCL_GEN_COMMAND_ID_HEADER

// Command directionality
#define ZCL_DIRECTION_CLIENT_TO_SERVER 0
#define ZCL_DIRECTION_SERVER_TO_CLIENT 1

// Global commands
// Either direction
#define ZCL_READ_ATTRIBUTES_COMMAND_ID 0x00                       // Ver.: always
#define ZCL_READ_ATTRIBUTES_RESPONSE_COMMAND_ID 0x01              // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_COMMAND_ID 0x02                      // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_UNDIVIDED_COMMAND_ID 0x03            // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_RESPONSE_COMMAND_ID 0x04             // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_NO_RESPONSE_COMMAND_ID 0x05          // Ver.: always
#define ZCL_CONFIGURE_REPORTING_COMMAND_ID 0x06                   // Ver.: always
#define ZCL_CONFIGURE_REPORTING_RESPONSE_COMMAND_ID 0x07          // Ver.: always
#define ZCL_READ_REPORTING_CONFIGURATION_COMMAND_ID 0x08          // Ver.: always
#define ZCL_READ_REPORTING_CONFIGURATION_RESPONSE_COMMAND_ID 0x09 // Ver.: always
#define ZCL_REPORT_ATTRIBUTES_COMMAND_ID 0x0A                     // Ver.: always
#define ZCL_DEFAULT_RESPONSE_COMMAND_ID 0x0B                      // Ver.: always
#define ZCL_DISCOVER_ATTRIBUTES_COMMAND_ID 0x0C                   // Ver.: always
#define ZCL_DISCOVER_ATTRIBUTES_RESPONSE_COMMAND_ID 0x0D          // Ver.: always
#define ZCL_READ_ATTRIBUTES_STRUCTURED_COMMAND_ID 0x0E            // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_STRUCTURED_COMMAND_ID 0x0F           // Ver.: always
#define ZCL_WRITE_ATTRIBUTES_STRUCTURED_RESPONSE_COMMAND_ID 0x10  // Ver.: always
#define ZCL_DISCOVER_COMMANDS_RECEIVED_COMMAND_ID 0x11            // Ver.: always
#define ZCL_DISCOVER_COMMANDS_RECEIVED_RESPONSE_COMMAND_ID 0x12   // Ver.: always
#define ZCL_DISCOVER_COMMANDS_GENERATED_COMMAND_ID 0x13           // Ver.: always
#define ZCL_DISCOVER_COMMANDS_GENERATED_RESPONSE_COMMAND_ID 0x14  // Ver.: always
#define ZCL_DISCOVER_ATTRIBUTES_EXTENDED_COMMAND_ID 0x15          // Ver.: always
#define ZCL_DISCOVER_ATTRIBUTES_EXTENDED_RESPONSE_COMMAND_ID 0x16 // Ver.: always

// Command types for cluster: On/off
// Cluster specification level: zcl-7.0-07-5123-07

// Client to server
#define ZCL_OFF_COMMAND_ID 0x00                         // Ver.: always
#define ZCL_ON_COMMAND_ID 0x01                          // Ver.: always
#define ZCL_TOGGLE_COMMAND_ID 0x02                      // Ver.: always
#define ZCL_OFF_WITH_EFFECT_COMMAND_ID 0x40             // Ver.: since zll-1.0-11-0037-10
#define ZCL_ON_WITH_RECALL_GLOBAL_SCENE_COMMAND_ID 0x41 // Ver.: since zll-1.0-11-0037-10
#define ZCL_ON_WITH_TIMED_OFF_COMMAND_ID 0x42           // Ver.: since zll-1.0-11-0037-10

#endif // CHIP_ZCL_GEN_COMMAND_ID_HEADER