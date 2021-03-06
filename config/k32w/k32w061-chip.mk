#
#   Copyright (c) 2020 Project CHIP Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

#
#   @file
#         Component makefile for incorporating CHIP into a k32w061
#         application.
#
#   This makefile is intended to work in conjunction with the k32w061-app.mk
#   makefile to build the CHIP example applications on NXP platforms.
#   k32w061 applications should include this file in their top level Makefile
#   after including k32w061-app.mk.  E.g.:
#
#       PROJECT_ROOT = $(realpath .)
#
#       BUILD_SUPPORT_DIR = $(PROJECT_ROOT)/third_party/connectedhomeip/config/k32w
#
#       include $(BUILD_SUPPORT_DIR)/k32w061-app.mk
#       include $(BUILD_SUPPORT_DIR)/k32w061-chip.mk
#
#       PROJECT_ROOT := $(realpath .)
#
#       APP := chip-k32w061-bringup
#
#       SRCS = \
#           $(PROJECT_ROOT)/main.cpp \
#           ...
#
#       $(call GenerateBuildRules)
#
# ==================================================
# General settings
# ==================================================

# Location of CHIP source tree
CHIP_ROOT ?= $(PROJECT_ROOT)/third_party/connectedhomeip

# Archtecture for which CHIP will be built.
CHIP_HOST_ARCH := armv7-unknown-linux-gnu

# Directory into which the CHIP build system will place its output.
CHIP_OUTPUT_DIR = $(OUTPUT_DIR)/chip

# An optional file containing application-specific configuration overrides.
CHIP_PROJECT_CONFIG = $(wildcard $(PROJECT_ROOT)/include/CHIPProjectConfig.h)

# Architcture on which CHIP is being built.
CHIP_BUILD_ARCH = $(shell $(CHIP_ROOT)/third_party/nlbuild-autotools/repo/third_party/autoconf/config.guess | sed -e 's/[[:digit:].]*$$//g')

# ==================================================
# Compilation flags specific to building CHIP
# ==================================================

CHIP_DEFINES += \

CHIP_DEFINE_FLAGS = $(foreach def,$(CHIP_DEFINES),-D$(def))
CHIP_CPPFLAGS = $(STD_CFLAGS) $(CFLAGS) $(DEBUG_FLAGS) $(OPT_FLAGS) $(DEFINE_FLAGS) $(CHIP_DEFINE_FLAGS) $(INC_FLAGS)
CHIP_CXXFLAGS = $(STD_CXXFLAGS) $(CXXFLAGS)

# ==================================================
# CHIP configuration options
# ==================================================

CHIP_CONFIGURE_OPTIONS = \
    -C AR="$(AR)" AS="$(AS)" CC="$(CCACHE) $(CC)" CXX="$(CCACHE) $(CXX)" \
    LD="$(LD)" OBJCOPY="$(OBJCOPY)" RANLIB="$(RANLIB)" INSTALL="$(INSTALL) $(INSTALLFLAGS)" \
    CPPFLAGS="$(CHIP_CPPFLAGS) -imacros $(CHIP_ROOT)/third_party/openthread/repo/examples/platforms/k32w/k32w061/k32w061-sdk-config.h" \
    CXXFLAGS="$(CHIP_CXXFLAGS)" \
    --prefix=$(CHIP_OUTPUT_DIR) \
    --exec-prefix=$(CHIP_OUTPUT_DIR) \
    --host=$(CHIP_HOST_ARCH) \
    --build=$(CHIP_BUILD_ARCH) \
    --with-target-style=embedded \
    --with-device-layer=k32w \
    --with-network-layer=all \
    --with-target-network=lwip \
    --with-lwip=internal \
    --with-lwip-target=k32w \
    --with-inet-endpoint="tcp udp" \
    --with-openssl=no \
    --with-openthread=internal \
    --with-logging-style=external \
    --with-chip-project-includes=$(CHIP_PROJECT_CONFIG) \
    --with-chip-system-project-includes=$(CHIP_PROJECT_CONFIG) \
    --with-chip-inet-project-includes=$(CHIP_PROJECT_CONFIG) \
    --with-chip-ble-project-includes=$(CHIP_PROJECT_CONFIG) \
    --with-chip-warm-project-includes=$(CHIP_PROJECT_CONFIG) \
    --with-chip-device-project-includes=$(CHIP_PROJECT_CONFIG) \
    --disable-ipv4 \
    --disable-tests \
    --disable-tools \
    --disable-docs \
    --disable-java \
    --disable-device-manager \
    --with-crypto=mbedtls

# Enable / disable optimization.
ifeq ($(OPT),1)
CHIP_CONFIGURE_OPTIONS += --enable-optimization=yes
else
CHIP_CONFIGURE_OPTIONS += --enable-optimization=no
endif

ifeq ($(DEBUG),1)
CHIP_CONFIGURE_OPTIONS += --enable-debug
endif
# ==================================================
# Adjustments to standard build settings to
#   incorporate CHIP
# ==================================================

# Add CHIP-specific paths to the standard include directories.
STD_INC_DIRS += \
    $(CHIP_OUTPUT_DIR)/include \
    $(CHIP_OUTPUT_DIR)/src/include \
    $(CHIP_ROOT)/third_party/lwip/repo/lwip/src/include \
    $(CHIP_ROOT)/src/lwip \
    $(CHIP_ROOT)/src/lwip/k32w \
    $(CHIP_ROOT)/src/lwip/freertos \
    $(K32W061_SDK_ROOT)/CMSIS/Include \
    $(K32W061_SDK_ROOT)/devices/K32W061 \
    $(K32W061_SDK_ROOT)/devices/K32W061/drivers \
    $(K32W061_SDK_ROOT)/devices/K32W061/utilities \
    $(K32W061_SDK_ROOT)/devices/K32W061/utilities/debug_console \
    $(K32W061_SDK_ROOT)/devices/K32W061/utilities/str \
    $(K32W061_SDK_ROOT)/middleware/wireless/framework/Common \
    $(K32W061_SDK_ROOT)/middleware/wireless/framework/Lists \
    $(K32W061_SDK_ROOT)/middleware/wireless/framework/PDM/Include \
    $(K32W061_SDK_ROOT)/middleware/wireless/framework/MemManager/Interface \
    $(CHIP_ROOT)/third_party/openthread/repo/examples/platforms

# Add the location of CHIP libraries to application link action.
STD_LDFLAGS += -L$(CHIP_OUTPUT_DIR)/lib

# Add CHIP libraries to standard libraries list.
STD_LIBS += \
    -lDeviceLayer \
    -lCHIP \
    -lInetLayer \
    -lSystemLayer \
    -llwip \
    -lmbedtls

# Add the appropriate CHIP target as a prerequisite to all application
# compilation targets to ensure that CHIP gets built and its header
# files installed prior to compiling any dependent source files.
STD_COMPILE_PREREQUISITES += install-chip

# Add the CHIP libraries as prerequisites for linking the application.
STD_LINK_PREREQUISITES += \
    $(CHIP_OUTPUT_DIR)/lib/libDeviceLayer.a \
    $(CHIP_OUTPUT_DIR)/lib/libCHIP.a \
    $(CHIP_OUTPUT_DIR)/lib/libInetLayer.a \
    $(CHIP_OUTPUT_DIR)/lib/libSystemLayer.a \
    $(CHIP_OUTPUT_DIR)/lib/liblwip.a \
    $(CHIP_OUTPUT_DIR)/lib/libmbedtls.a \

# ==================================================
# Late-bound build rules for CHIP
# ==================================================

# Add CHIPBuildRules to the list of late-bound build rules that
# will be evaluated when GenerateBuildRules is called.
LATE_BOUND_RULES += CHIPBuildRules

# Rules for configuring, building and installing CHIP.
define CHIPBuildRules

.PHONY : config-chip .check-config-chip build-chip install-chip clean-chip

.check-config-chip : | $(CHIP_OUTPUT_DIR)
	$(NO_ECHO)echo $(CHIP_ROOT)/configure $(CHIP_CONFIGURE_OPTIONS) > $(CHIP_OUTPUT_DIR)/config.args.tmp; \
	(test -r $(CHIP_OUTPUT_DIR)/config.args && cmp -s $(CHIP_OUTPUT_DIR)/config.args.tmp $(CHIP_OUTPUT_DIR)/config.args) || \
	    mv $(CHIP_OUTPUT_DIR)/config.args.tmp $(CHIP_OUTPUT_DIR)/config.args; \
	 rm -f $(CHIP_OUTPUT_DIR)/config.args.tmp;

$(CHIP_OUTPUT_DIR)/config.args : .check-config-chip
	@: # Null action required to work around make's crazy timestamp caching behavior.

$(CHIP_ROOT)/configure : $(CHIP_ROOT)/configure.ac
	@echo "$(HDR_PREFIX)BOOTSTRAP CHIP..."
	$(NO_ECHO)(cd $(CHIP_ROOT) && ./bootstrap)

$(CHIP_OUTPUT_DIR)/config.status : $(CHIP_ROOT)/configure $(CHIP_OUTPUT_DIR)/config.args
	@echo "$(HDR_PREFIX)CONFIGURE CHIP..."
	$(NO_ECHO)(cd $(CHIP_OUTPUT_DIR) && $(CHIP_ROOT)/configure $(CHIP_CONFIGURE_OPTIONS))

config-chip : $(CHIP_OUTPUT_DIR)/config.status | $(OPENTHREAD_PREREQUISITE)

build-chip : config-chip
	@echo "$(HDR_PREFIX)BUILD CHIP..."
	$(NO_ECHO)MAKEFLAGS= make -C $(CHIP_OUTPUT_DIR) --no-print-directory all V=$(VERBOSE)

install-chip : | build-chip
	@echo "$(HDR_PREFIX)INSTALL CHIP..."
	$(NO_ECHO)MAKEFLAGS= make -C $(CHIP_OUTPUT_DIR) --no-print-directory install V=$(VERBOSE)

clean-chip:
	@echo "$(HDR_PREFIX)RM $(CHIP_OUTPUT_DIR)"
	$(NO_ECHO)rm -rf $(CHIP_OUTPUT_DIR)

$(CHIP_OUTPUT_DIR) :
	@echo "$(HDR_PREFIX)MKDIR $$@"
	$(NO_ECHO)mkdir -p "$$@"

endef
# ==================================================
# CHIP-specific help definitions
# ==================================================

define TargetHelp +=


  config-chip          Run the CHIP configure script.

  build-chip           Build the CHIP libraries.

  install-chip         Install CHIP libraries and headers in
                        build output directory for use by application.

  clean-chip           Clean all build outputs produced by the CHIP
                        build process.
endef
