
.PHONY: all clean

IMGTYPE:=1M
UPDADDR:=90000
RUNADDR:=10100

include_dir:=-Isrcdir/include/

output_dir:=output
proj_cflags:= -mthumb -mcpu=cortex-m3  \
	 -ffunction-sections -fdata-sections -fno-builtin -mlittle-endian
#proj_cflags += -nostdinc

proj_ldflags := -static -mthumb -mcpu=cortex-m3
proj_ldflags += -nostartfiles -nostdlib
proj_ldflags += -Tsrcdir/cmd_link.lds -Wl,-Map -Wl,${output_dir}/proj.map

#####remove unused section to reduce code size #####
#proj_ldflags += -Wl,--gc-sections -n -Wl,-cref

c_src_file:=srcdir/main.c srcdir/wm_gpio.c srcdir/wm_gpio_afsel.c srcdir/wm_io.c srcdir/wm_irq.c \
	srcdir/wm_misc.c
asm_src_file:=srcdir/startup_cm3.S
objfile:=$(c_src_file:%.c=%.o) $(asm_src_file:%.S=%.o)
objfile:=$(patsubst srcdir/%.o, ${output_dir}/%.o, ${objfile})

${output_dir}/proj_burn.FLS:${output_dir}/proj.bin
	@tools/wm_tool -b ${output_dir}/proj.bin -sb secboot/secboot.img -fc compress -it ${IMGTYPE} \
-ua ${UPDADDR} -ra ${RUNADDR} -df -o $@

${output_dir}/proj.bin:${output_dir}/proj.elf
	arm-none-eabi-objcopy -O binary $< $@

${output_dir}/proj.elf:$(objfile)
	arm-none-eabi-gcc -o $@  $^ ${proj_ldflags}
	@echo
	@arm-none-eabi-size $@

${output_dir}/%.o:srcdir/%.c FORCE
	@mkdir -p output
	arm-none-eabi-gcc ${proj_flags} ${include_dir} -c $< -o $@

${output_dir}/%.o:srcdir/%.S FORCE
	@mkdir -p output
	arm-none-eabi-gcc ${proj_flags} ${include_dir} -c $< -o $@

FORCE:
clean:
	@-rm -rf ${output_dir}/*.*
