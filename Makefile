APPNAME = Black Ops II
TITLE = BLACKOPS2
TARGET   = BO2
OBJS     = src/main.o

LIBS = -lSceLibKernel_stub -lSceDisplay_stub -lSceTouch_stub -lSceAudio_stub \
  -lvita2d -lSceDisplay_stub -lSceGxm_stub -lSceSysmodule_stub -lSceCtrl_stub \
  -lScePgf_stub -lScePvf_stub -lSceCommonDialog_stub -lfreetype -lpng \
  -ljpeg -lz -lm -lc -lsoloud

PREFIX  = arm-vita-eabi
CXX      = $(PREFIX)-g++
CFLAGS  = -Wl,-q -Wall -fno-lto
ASFLAGS = $(CFLAGS)

# Link against the locally-built version of libvita2d if possible
LIBS += -L../libvita2d
CFLAGS += -I../libvita2d/include

all: $(TARGET).vpk

%.vpk: eboot.bin
	vita-mksfoex -s TITLE_ID="$(TITLE)" "$(APPNAME)" param.sfo
	vita-pack-vpk -s param.sfo -b eboot.bin \
		--add font/bo2.ttf=font/bo2.ttf \
		--add font/agencyfb.ttf=font/agencyfb.ttf \
		--add images/logo.png=images/logo.png \
		--add sce_sys/icon0.png=sce_sys/icon0.png \
		--add sce_sys/livearea/contents/bg.png=sce_sys/livearea/contents/bg.png \
		--add sce_sys/livearea/contents/template.xml=sce_sys/livearea/contents/template.xml \
		--add sce_sys/livearea/contents/startup.png=sce_sys/livearea/contents/startup.png \
		--add sce_sys/pic0.png=sce_sys/pic0.png \
		$(TITLE).vpk

eboot.bin: $(TARGET).velf
	vita-make-fself -s $< $@

%.velf: %.elf
	vita-elf-create $< $@

$(TARGET).elf: $(OBJS)
	$(CXX) $(CFLAGS) $^ $(LIBS) -o $@

%.o: %.png
	$(PREFIX)-ld -r -b binary -o $@ $^

clean:
	@rm -rf $(TARGET).vpk $(TARGET).velf $(TARGET).elf $(OBJS) \
		eboot.bin param.sfo

vpksend: $(TARGET).vpk
	curl -T $(TARGET).vpk ftp://$(PSVITAIP):1337/ux0:/
	@echo "Sent."

send: eboot.bin
	curl -T eboot.bin ftp://$(PSVITAIP):1337/ux0:/app/$(TITLE_ID)/
	@echo "Sent."
