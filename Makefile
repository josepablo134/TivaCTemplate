PJ_FOLDER=project

OUTPUT_FOLDER=./output
OBJS_PATH=./output

SRC=\
	$(PJ_FOLDER)/board/startup_gcc.c\
#	$(wildcard $(PJ_FOLDER)/lib/driverlib/*.c)

INC_FOLDER=\
   $(PJ_FOLDER)/lib/\
   $(PJ_FOLDER)/lib/driverlib/\
   $(PJ_FOLDER)/lib/driverlib/inc

INC_LIBS=\
	$(PJ_FOLDER)/lib/driverlib/gcc/libdriver.a

CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
OC=arm-none-eabi-objcopy

LINKER_SCRIPT=tm4c1294.ld

OBJS= $(OBJS_PATH)/main.o\
	$(OBJS_PATH)/startup_gcc.o\
#	$(foreach d, $(SRC), $(OBJS_PATH)/$(basename $(notdir $d)).o)

OUTPUT_ELF=$(OUTPUT_FOLDER)/output.elf
OUTPUT_S19=$(OUTPUT_FOLDER)/output.s19
OUTPUT_HEX=$(OUTPUT_FOLDER)/output.hex
OUTPUT_MAP=$(OUTPUT_FOLDER)/output.map

CFLAGS= $(foreach d, $(INC_FOLDER), -I$d)
CFLAGS+=-g3 -gdwarf-2 -fno-exceptions -nostartfiles -nodefaultlibs -nostdlib -lgcc -lc
CFLAGS+=-mthumb
CFLAGS+=-mcpu=cortex-m4
CFLAGS+=-mfpu=fpv4-sp-d16
CFLAGS+=-mfloat-abi=hard
CFLAGS+=-DTARGET_IS_TM4C129_RA1
CFLAGS+=-DPART_TM4C129XNCZAD

.PHONY: all
all: $(OBJS) $(INC_LIBS)
	$(LD) -n -T $(LINKER_SCRIPT) -Map $(OUTPUT_MAP) $^ -o $(OUTPUT_ELF) 
#	$(LD) -n $(foreach d, $(INC_LIBS), -l$d) -T $(LINKER_SCRIPT) -Map $(OUTPUT_MAP) $^ -o $(OUTPUT_ELF) 
	$(OC) --srec-forceS3 -O srec $(OUTPUT_ELF) $(OUTPUT_S19)
	$(OC) -O ihex $(OUTPUT_ELF) $(OUTPUT_HEX)

$(OBJS_PATH)/main.o: main.c
	$(CC) $(CFLAGS) -o $(OBJS_PATH)/main.o -c $^

$(OBJS_PATH)/startup_gcc.o: $(PJ_FOLDER)/board/startup_gcc.c
	$(CC) $(CFLAGS) -o $(OBJS_PATH)/startup_gcc.o -c $^

$(OBJS_PATH)/%.o: $(PJ_FOLDER)/lib/driverlib/%.c
	$(CC) $(CFLAGS) -o $@ -c $^

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
