INSTALL_TARGET_PROCESSES = SpringBoard SpringBoardHome
# TARGET = simulator:clang::7.0
# ARCHS = x86_64 i386
ARCHS = armv7s arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = testing

testing_FILES = Tweak.x
testing_CFLAGS = -fobjc-arc
testing_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dockifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
