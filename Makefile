ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Dockify

Dockify_FILES = Dockify.x
Dockify_CFLAGS = -fobjc-arc
Dockify_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dockifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
