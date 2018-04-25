TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += ls218Support

# Compile and add code to the support library
ls218Support_SRCS += xxxRecord.c
ls218Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
ls218Support_SRCS += dbSubExample.c
ls218Support_SRCS += devls218Version.c
ls218Support_SRCS += ls218Hello.c
ls218Support_SRCS += initTrace.c

ls218Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = ls218Version.h
# Macro name
GENVERSIONMACRO = ls218VERSION

# Build the IOC application
PROD_IOC = ls218
PROD_LIBS += asyn
PROD_LIBS += stream

# ls218.dbd will be created and installed
DBD += ls218.dbd

# ls218.dbd will include these files:
ls218_DBD += base.dbd
ls218_DBD += asyn.dbd
ls218_DBD += stream.dbd
ls218_DBD += xxxSupport.dbd
ls218_DBD += dbSubExample.dbd
ls218_DBD += devls218Version.dbd
ls218_DBD += ls218Hello.dbd
ls218_DBD += initTrace.dbd
ls218_DBD += drvLinuxGpib.dbd

# ls218_registerRecordDeviceDriver.cpp derives from ls218.dbd
ls218_SRCS += ls218_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
ls218_SRCS_DEFAULT += ls218Main.cpp
ls218_SRCS_vxWorks += -nil-

# Link in the code from our support library
ls218_LIBS += ls218Support

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into ls218Support
    sncExample_SNCFLAGS += +r
    ls218_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    ls218Support_SRCS += sncExample.stt
    ls218Support_LIBS += seq pv
    ls218_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    ls218_LIBS += qsrv
    ls218_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    ls218_DBD += PVAServerRegister.dbd
    ls218_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
ls218_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devls218Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
