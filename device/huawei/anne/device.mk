# MicroG integration for ANE-LX1
# This file is included by the main device.mk

# MicroG
PRODUCT_PACKAGES += \
    GmsCore \
    GsfProxy \
    FakeStore

# Enable MicroG
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.microg.enabled=true

# Signature spoofing support (required for MicroG)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.signature_spoofing.enabled=true

# Disable Play Services (we use MicroG)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.gmsversion=0