TARGET := iphone:clang:latest:6.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WhaTFixer

WhaTFixer_FILES = Tweak.x
WhaTFixer_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
