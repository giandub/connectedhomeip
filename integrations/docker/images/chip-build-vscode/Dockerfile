ARG VERSION=latest
FROM connectedhomeip/chip-build-nrf-platform:${VERSION} AS nrf
FROM connectedhomeip/chip-build-efr32:${VERSION} AS efr32
FROM connectedhomeip/chip-build-android:${VERSION} AS android
FROM connectedhomeip/chip-build-esp32-qemu:${VERSION} as esp32
FROM connectedhomeip/chip-build:${VERSION}
COPY --from=esp32 /opt/expressif/esp-idf /opt/expressif/esp-idf
COPY --from=esp32 /opt/expressif/tools /opt/expressif/tools
COPY --from=esp32 /opt/expressif/qemu /opt/expressif/qemu
COPY --from=nrf /opt/NordicSemiconductor/nRF5_tools /opt/NordicSemiconductor/nRF5_tools
COPY --from=nrf /opt/NordicSemiconductor/nRF5_SDK_for_Thread_and_Zigbee /opt/NordicSemiconductor/nRF5_SDK_for_Thread_and_Zigbee
COPY --from=nrf /opt/ARM-software/gcc-arm-none-eabi-9-2019-q4-major /opt/ARM-software/gcc-arm-none-eabi-9-2019-q4-major
COPY --from=efr32 /opt/SiliconLabs/sdk_support /opt/SiliconLabs/sdk_support
COPY --from=android /opt/android/sdk /opt/android/sdk
COPY --from=android /opt/android/android-ndk-r21b /opt/android/android-ndk-r21b
ENV IDF_PATH=/opt/expressif/esp-idf/
ENV IDF_TOOLS_PATH=/opt/expressif/tools
ENV QEMU_ESP32_DIR=/opt/expressif/qemu
ENV QEMU_ESP32=/opt/expressif/qemu/xtensa-softmmu/qemu-system-xtensa
ENV NRF5_SDK_ROOT=/opt/NordicSemiconductor/nRF5_SDK_for_Thread_and_Zigbee
ENV NRF5_TOOLS_ROOT=/opt/NordicSemiconductor/nRF5_tools
ENV ARM_GCC_INSTALL_ROOT=/opt/ARM-software/gcc-arm-none-eabi-9-2019-q4-major/bin
ENV EFR32_SDK_ROOT=/opt/SiliconLabs/sdk_support
ENV EFR32_BOARD=BRD4161A
ENV ANDROID_HOME=/opt/android/sdk
ENV ANDROID_NDK_HOME=/opt/android/android-ndk-r21b
ENV PW_ENVIRONMENT_ROOT=/home/vscode/pigweed/env
