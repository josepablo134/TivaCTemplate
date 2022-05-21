PJ_FOLDER=project

OUTPUT_FOLDER=./output
OBJS_PATH=./output

SRC=\
	$(wildcard $(PJ_FOLDER)/*.c)\
	$(wildcard $(PJ_FOLDER)/board/*.c)\
	$(wildcard $(PJ_FOLDER)/lib/FreeRTOS/*.c)\
	$(wildcard $(PJ_FOLDER)/lib/FreeRTOS/portable/*.c)\

INC_FOLDER=\
   $(PJ_FOLDER)/board/\
   $(PJ_FOLDER)/lib/\
   $(PJ_FOLDER)/lib/driverlib/\
   $(PJ_FOLDER)/lib/driverlib/inc\
   $(PJ_FOLDER)/lib/FreeRTOS/inc\
   $(PJ_FOLDER)/lib/FreeRTOS/portable\
   $(PJ_FOLDER)/lib/MemMap\

INC_LIBS=\
	$(PJ_FOLDER)/lib/driverlib/gcc/libdriver.a\
	/usr/arm-none-eabi/lib/thumb/v7+fp/hard/libc.a\

CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
OC=arm-none-eabi-objcopy

PRE_LINKER_SCRIPT=tm4c1294_cfg.ld
LINKER_SCRIPT=tm4c1294.ld

OBJS= \
	$(foreach d, $(notdir $(SRC)), $(OBJS_PATH)/$(basename $d).o ) \

OUTPUT_ELF=$(OUTPUT_FOLDER)/output.elf
OUTPUT_S19=$(OUTPUT_FOLDER)/output.s19
OUTPUT_HEX=$(OUTPUT_FOLDER)/output.hex
OUTPUT_MAP=$(OUTPUT_FOLDER)/output.map

CFLAGS= $(foreach d, $(INC_FOLDER), -I$d)
CFLAGS+=-nostdlib -fno-exceptions -nostartfiles -nodefaultlibs
CFLAGS+=-g3 -gdwarf-2 -lgcc -lc
CFLAGS+=-mthumb
CFLAGS+=-mcpu=cortex-m4
CFLAGS+=-mfpu=fpv4-sp-d16
CFLAGS+=-mfloat-abi=hard
CFLAGS+=-DTARGET_IS_TM4C129_RA1
CFLAGS+=-DPART_TM4C129XNCZAD

.PHONY: all
all: $(OBJS) $(INC_LIBS)
	$(LD) -n -T $(LINKER_SCRIPT) -Map $(OUTPUT_MAP) $^ -o $(OUTPUT_ELF) 
	$(OC) --srec-forceS3 -O srec $(OUTPUT_ELF) $(OUTPUT_S19)
	$(OC) -O ihex $(OUTPUT_ELF) $(OUTPUT_HEX)


$(OBJS_PATH)/%.o: $(PJ_FOLDER)/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

$(OBJS_PATH)/%.o: $(PJ_FOLDER)/board/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

$(OBJS_PATH)/%.o: $(PJ_FOLDER)/lib/driverlib/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

$(OBJS_PATH)/%.o: $(PJ_FOLDER)/lib/FreeRTOS/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

$(OBJS_PATH)/%.o: $(PJ_FOLDER)/lib/FreeRTOS/portable/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

.PHONY: config
config: $(LINKER_SCRIPT)
	@mkdir -p $(OUTPUT_FOLDER)
	@mkdir -p $(OBJS_PATH)

$(LINKER_SCRIPT): $(PRE_LINKER_SCRIPT)
	$(CC) -E -P -x c $^ -o $(LINKER_SCRIPT)

.PHONY: clean
clean:
	rm $(OUTPUT_FOLDER)/*.o
	rm $(OUTPUT_FOLDER)/*.map
	rm $(OUTPUT_FOLDER)/*.elf
	rm $(OUTPUT_FOLDER)/*.hex
	rm $(OUTPUT_FOLDER)/*.s19

.PHONY: rebuild
rebuild: clean all
	@echo "Done"
