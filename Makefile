ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include /Users/carsonzielinski/Documents/theos/makefiles/common.mk

TWEAK_NAME = testing

testing_FILES = Tweak.x
testing_CFLAGS = -fobjc-arc
testing_EXTRA_FRAMEWORKS += Cephei

include /Users/carsonzielinski/Documents/theos/makefiles/tweak.mk
SUBPROJECTS += dockifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
