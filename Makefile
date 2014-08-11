MODNAME=hdmi-cec
LINUX_VERSION?=$(shell uname -r)
LINUX_DIR?=/lib/modules/$(LINUX_VERSION)/build
INST_DIR?=/lib/modules/$(LINUX_VERSION)/extra

obj-m	:= $(MODNAME).o hdmi-cec-example.o
MODOBJS	:=core.o dev.o
$(MODNAME)-y := $(MODOBJS)
$(MODNAME)-example-y := driver.o
ccflags-y := -I. -D__EXT_BUILD__

all:
	$(MAKE) -C $(LINUX_DIR) M=$$PWD

install:
	$(MAKE) -C $(LINUX_DIR) INSTALL_MOD_DIR=$(INST_DIR) \
		M=$$PWD modules_install

clean:
	$(MAKE) -C $(LINUX_DIR) M=$$PWD clean
