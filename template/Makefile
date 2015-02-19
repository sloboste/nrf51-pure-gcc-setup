TOOLCHAIN_PREFIX ?= arm-none-eabi

AS = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-as
CC = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gcc
LD = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gcc
OBJCOPY = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-objcopy
OBJDUMP = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-objdump
SIZE = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-size
GDB = $(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)-gdb

START_CODE ?= startup_nrf51.s
SYSTEM_FILE ?= system_nrf51.c

ifeq ($(USE_SOFTDEVICE), s110)
    USE_BLE = 1
endif

ifeq ($(USE_SOFTDEVICE), s120)
    USE_BLE = 1
endif

ifeq ($(USE_SOFTDEVICE), s210)
    USE_ANT = 1
endif

ifeq ($(USE_SOFTDEVICE), s310)
    USE_BLE = 1
    USE_ANT = 1
endif


ifeq ($(SDK_VERSION), iot)
	# This is for the IOT SDK version
	# Under "nRF51 IoT SDK Zip File" on the Downloads tab on the nrf51 chips

	START_CODE = gcc_startup_nrf51.s

	SDK_INCLUDE_PATH += $(SDK_PATH)components
	SDK_SOURCE_PATH += $(SDK_PATH)components
	CMSIS_INCLUDE_PATH += $(SDK_PATH)components/toolchain/gcc/

	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/toolchain/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/toolchain/gcc/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/softdevice/common/softdevice_handler/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/softdevice/s1xx_iot/headers/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/coap/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/include/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/pbuffer/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/udp/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/icmp6/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/include/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/include/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/include/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/ipv6_stack/utils/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/iot/context_manager/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/ble/ble_6lowpan/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/ble/ble_services/ble_ipsp/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/ble/common/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/drivers_nrf/simple_uart/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/drivers_nrf/nrf_soc_nosd/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/drivers_nrf/uart/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/drivers_nrf/hal/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/util/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/gpiote/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/trace/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/button/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/scheduler/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/timer/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)/libraries/mem_manager/

	SOURCE_PATHS += $(SDK_SOURCE_PATH)/toolchain/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/toolchain/gcc/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/softdevice/common/softdevice_handler/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/coap/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/ipv6_stack/pbuffer/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/ipv6_stack/ipv6/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/ipv6_stack/udp/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/ipv6_stack/icmp6/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/ipv6_stack/utils/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/iot/context_manager/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/ble/common/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/drivers_nrf/simple_uart/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/drivers_nrf/hal/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/util/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/gpiote/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/trace/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/button/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/scheduler/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/timer/
	SOURCE_PATHS += $(SDK_SOURCE_PATH)/libraries/mem_manager/

	LIBS += $(SDK_SOURCE_PATH)/ble/ble_6lowpan/lib/ble_6lowpan.a

	ifdef USE_BLE
	    CFLAGS += -DBLE_STACK_SUPPORT_REQD
	endif

	ifdef USE_SOFTDEVICE
		CFLAGS += -DSOFTDEVICE_PRESENT
		CFLAGS += -DS110
		CFLAGS += -D__HEAP_SIZE=512
		CFLAGS += -O3

		CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
		CFLAGS += -flto -fno-builtin
	endif

	# LDFLAGS += -Xlinker
	# LDFLAGS += -mabi=aapcs
	# let linker to dump unused sections
	LDFLAGS += -Wl,--gc-sections
	# use newlib in nano version
	LDFLAGS += --specs=nano.specs -lc -lnosys

	# # ASMFLAGS += --specs=nosys.spec
	ASMFLAGS += -x assembler-with-cpp
	ASMFLAGS += -DNRF51
	ASMFLAGS += -DBOARD_NRF6310
	ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
	ASMFLAGS += -DS110
	ASMFLAGS += -D__HEAP_SIZE=512
	ASMFLAGS += -DSOFTDEVICE_PRESENT


else
ifeq ($(SDK_VERSION), 7)
#this is for version 7

	SDK_INCLUDE_PATH += $(SDK_PATH)components/
	SDK_SOURCE_PATH += $(SDK_PATH)components/
	CMSIS_INCLUDE_PATH += $(SDK_PATH)components/toolchain/gcc/
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)libraries/*/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/ble_flash/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/hal/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/pstorage/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/radio_config/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/sdio/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/simple_uart/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/spi_master/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/spi_slave/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/twi_master/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/uart/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_ext/*/)
	LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)serialization/*/)
	LIBRARY_PATHS += $(SDK_PATH)components/toolchain/gcc/
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)toolchain/
	SOURCE_PATHS += ../
	SOURCE_PATHS += $(SDK_SOURCE_PATH)
	SOURCE_PATHS += $(TEMPLATE_PATH)
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)*/)
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)libraries/*/)
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)drivers_nrf/*/)
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)drivers_ext/*/)
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)serialization/*/)

	ifdef USE_BLE
	    LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)ble/*/)
	    LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)ble/ble_services/*/)
	    SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)ble/*/)
	    SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)ble/ble_services/*/)
	    CFLAGS += -DBLE_STACK_SUPPORT_REQD
	    CFLAGS  = -DNRF51
CFLAGS += -DS110
	endif

	ifdef USE_ANT
	    CFLAGS += -DANT_STACK_SUPPORT_REQD
	endif

	ifdef USE_SOFTDEVICE
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)softdevice/common/softdevice_handler/
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)softdevice/$(USE_SOFTDEVICE)/headers/
	    SOURCE_PATHS += $(SDK_INCLUDE_PATH)softdevice/common/softdevice_handler/
	    SOURCE_PATHS += $(SDK_INCLUDE_PATH)softdevice/$(USE_SOFTDEVICE)/headers/
	else
		LIBRARY_PATHS += $(wildcard $(SDK_INCLUDE_PATH)drivers_nrf/nrf_soc_nosd/)
	    USE_SOFTDEVICE = blank
	endif

	ASMFLAGS += -x assembler-with-cpp
ASMFLAGS += -DNRF51
ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
ASMFLAGS += -DS110
ASMFLAGS += -DSOFTDEVICE_PRESENT



else
	#this is for version 6(default)

	SDK_INCLUDE_PATH += $(SDK_PATH)Include/
	SDK_SOURCE_PATH += $(SDK_PATH)Source/
	CMSIS_INCLUDE_PATH += $(SDK_PATH)Include/gcc

	LIBRARY_PATHS += ../
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)sdk/
	SOURCE_PATHS += ../ $(SDK_SOURCE_PATH) $(TEMPLATE_PATH) $(wildcard $(SDK_SOURCE_PATH)*/)

	ifdef USE_BLE
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)ble/
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)ble/ble_services/
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)ble/device_manager/
	    SOURCE_PATHS += $(SDK_SOURCE_PATH)ble/ble_services/
	    SOURCE_PATHS += $(SDK_SOURCE_PATH)ble/device_manager/
	    CFLAGS += -DBLE_STACK_SUPPORT_REQD
	endif

	ifdef USE_ANT
	    CFLAGS += -DANT_STACK_SUPPORT_REQD
	endif

	ifdef USE_SOFTDEVICE
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)$(USE_SOFTDEVICE)
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)app_common/
	    LIBRARY_PATHS += $(SDK_INCLUDE_PATH)sd_common/
	else
	    USE_SOFTDEVICE = blank
	endif

	ifdef USE_EXT_SENSORS
	LIBRARY_PATHS += $(SDK_INCLUDE_PATH)ext_sensors/
	SOURCE_PATHS += $(wildcard $(SDK_SOURCE_PATH)ext_sensors/*/)
	endif

endif
endif

print-% : ; @echo $* = $($*)

LINKER_SCRIPT ?= gcc_nrf51_$(USE_SOFTDEVICE).ld
OUTPUT_NAME ?= $(addsuffix _$(USE_SOFTDEVICE), $(PROJECT_NAME))

LIBRARY_INCLUDES = $(addprefix -I,$(LIBRARY_PATHS))
CMSIS_INCLUDE = $(addprefix -I,$(CMSIS_INCLUDE_PATH))

VPATH = $(SOURCE_PATHS)

OUTPUT_PATH = _build/

CPUFLAGS = -mthumb -mabi=aapcs -mcpu=cortex-m0 -march=armv6-m
CFLAGS += -std=gnu99 -c $(CPUFLAGS) -Wall -D$(DEVICE) -D$(BOARD) $(CMSIS_INCLUDE) $(LIBRARY_INCLUDES) -MD
LDFLAGS += $(CPUFLAGS) -L $(TEMPLATE_PATH) -T $(LINKER_SCRIPT) -Wl,-Map=$(OUTPUT_PATH)$(OUTPUT_NAME).Map




HEX = $(OUTPUT_PATH)$(OUTPUT_NAME).hex
ELF = $(OUTPUT_PATH)$(OUTPUT_NAME).elf
BIN = $(OUTPUT_PATH)$(OUTPUT_NAME).bin

SRCS = $(SYSTEM_FILE) $(notdir $(APPLICATION_SRCS))
OBJS = $(addprefix $(OUTPUT_PATH), $(SRCS:.c=.o)) $(addprefix $(OUTPUT_PATH),$(APPLICATION_LIBS))
DEPS = $(addprefix $(OUTPUT_PATH), $(SRCS:.c=.d))
SRCS_AS = $(START_CODE)
OBJS_AS = $(addprefix $(OUTPUT_PATH), $(SRCS_AS:.s=.os))

JLINK_OPTIONS = -device nrf51822 -if swd -speed 1000

all: $(OBJS) $(OBJS_AS) $(HEX)

rebuild: clean all

ifeq ($(OS),Windows_NT)
include $(TEMPLATE_PATH)Makefile.windows
else
include $(TEMPLATE_PATH)Makefile.posix
endif

$(HEX): $(OBJS) $(OBJS_AS)
	$(LD) $(LDFLAGS) $(OBJS_AS) $(OBJS) $(LIBS) -o $(ELF)
	$(OBJCOPY) -Oihex $(ELF) $(HEX)
	$(OBJCOPY) -Obinary $(ELF) $(BIN)
	$(SIZE) $(ELF)

size: $(ELF)
	$(SIZE) $(ELF)

$(OUTPUT_PATH)%.o: %.c
	$(MAKE_BUILD_FOLDER)
	$(CC) $(LDFLAGS) $(CFLAGS) $< -o $@

$(OUTPUT_PATH)%.os: %.s
	$(MAKE_BUILD_FOLDER)
	$(CC) $(ASMFLAGS) $< -c -o $@

-include $(DEPS)

.PHONY: all clean rebuild size
