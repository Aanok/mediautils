DIR := $(shell pwd)

install:
	@ln -s "$(DIR)/h265" /usr/bin/h265 && ln -s "$(DIR)/audio2opus" /usr/bin/audio2opus && ln -s "$(DIR)/cuesplit" /usr/bin/cuesplit

uninstall:
	@rm /usr/bin/h265 /usr/bin/audio2opus /usr/bin/cuesplit
