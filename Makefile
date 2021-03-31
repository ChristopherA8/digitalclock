TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DigitalClock

DigitalClock_FILES = $(wildcard *.m *xm)
DigitalClock_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_LIBRARIES = colorpicker
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += digitalclockprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
