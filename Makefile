CC=armclang
AS=armclang
LD=armlink

ASFLAGS= -c --target=aarch64-arm-none-eabi
CFLAGS= -c --target=aarch64-arm-none-eabi -I"./include" -O1 -DITERATIONS=10 -DCOMPILER_FLAGS=\"-O1\" -DSEED_METHOD=SEED_ARG

# Select build rules based on Windows or Unix
ifdef WINDIR
DONE=@if exist $(1) if exist $(2) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) if exist $(2) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then if [ -f $(2) ]; then echo Build completed.; fi; fi
RM=rm -f $(1)
endif
endif

all: coremark.axf
	$(call DONE,$(EXECUTABLE))

clean:
	$(call RM,*.o)
	$(call RM,coremark.axf)

core_main.o: ./src/core_main.c
	$(CC) ${CFLAGS} ./src/core_main.c

core_list_join.o: ./src/core_list_join.c
	$(CC) ${CFLAGS} ./src/core_list_join.c

core_matrix.o: ./src/core_matrix.c
	$(CC) ${CFLAGS} ./src/core_matrix.c

core_state.o: ./src/core_state.c
	$(CC) ${CFLAGS} ./src/core_state.c

core_util.o: ./src/core_util.c
	$(CC) ${CFLAGS} ./src/core_util.c

core_portme.o: ./src/core_portme.c
	$(CC) ${CFLAGS} ./src/core_portme.c	
	
startup.o: ./asm/startup.s
	$(AS) ${ASFLAGS} ./asm/startup.s

coremark.axf: startup.o core_main.o core_list_join.o core_matrix.o core_state.o core_util.o core_portme.o scatter.txt
	$(LD) --scatter=scatter.txt startup.o core_main.o core_list_join.o core_matrix.o core_state.o core_util.o core_portme.o -o coremark.axf --entry=start64

run:
	@FVP_Base_RevC-2xAEMvA -a ./coremark.axf -C bp.secure_memory=false -C cache_state_modelled=0
