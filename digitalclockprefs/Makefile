TARGET := iphone:clang:latest:7.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = digitalclockprefs

$(BUNDLE_NAME)_FILES = $(wildcard *.m)
digitalclockprefs_FRAMEWORKS = UIKit
digitalclockprefs_LIBRARIES = colorpicker
digitalclockprefs_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
digitalclockprefs_INSTALL_PATH = /Library/PreferenceBundles
digitalclockprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
