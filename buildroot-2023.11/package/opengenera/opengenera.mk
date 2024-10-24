OPENGENERA_VERSION = 8.5
OPENGENERA_SITE = https://archives.loomcom.com/genera

# Commands to fetch OpenGenera and the associated files
define OPENGENERA_BUILD_CMDS
	# Create a build directory for OpenGenera
	mkdir -p $(BUILD_DIR)/opengenera-$(OPENGENERA_VERSION)

	# Change to the build directory
	cd $(BUILD_DIR)/opengenera-$(OPENGENERA_VERSION)

	# Fetch the necessary world, debugger, and VLM files
	curl -L -O $(OPENGENERA_SITE)/worlds/Genera-8-5-xlib-patched.vlod
	curl -L -O $(OPENGENERA_SITE)/worlds/VLM_debugger
	curl -L -O $(OPENGENERA_SITE)/worlds/dot.VLM

	# Rename 'dot.VLM' to '.VLM'
	mv dot.VLM .VLM

	# Fetch the var_lib_symbolics.tar.gz file and extract it to /var/lib
	sudo curl -L -O $(OPENGENERA_SITE)/var_lib_symbolics.tar.gz
	sudo tar -xvf var_lib_symbolics.tar.gz -C $(BUILD_DIR)/opengenera-$(OPENGENERA_VERSION)

endef

# Commands to install OpenGenera to the target directory
define OPENGENERA_INSTALL_TARGET_CMDS
	# Create the destination directory on the target system
	mkdir -p $(TARGET_DIR)/opt/opengenera

	# Copy the downloaded files to the target's /opt/opengenera directory
	cp -r $(BUILD_DIR)/opengenera-$(OPENGENERA_VERSION)/* $(TARGET_DIR)/opt/opengenera/
endef

# Evaluate the generic-package build steps
$(eval $(generic-package))

