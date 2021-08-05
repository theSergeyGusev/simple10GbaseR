default: all

SEED?=$(shell date +%N)

USR_OPTS?=
GUI?=0

ifeq ($(GUI),1)
	GUI_ENABLE:=
	DO:=do.do
	OPT:=-novopt
else
	GUI_ENABLE:=-c
	DO:="run -a"
	OPT:=
endif

TEST_LIST+=test_r100_lin_b64_b64          
TEST_LIST+=test_r100_lin_b1500_b1500  
TEST_LIST+=test_r100_lin_b64_b1500    
TEST_LIST+=test_r100_rnd_b64_b1500    
TEST_LIST+=test_r50_lin_b64_b64       
TEST_LIST+=test_r50_lin_b1500_b1500   
TEST_LIST+=test_r50_lin_b64_b1500     
TEST_LIST+=test_r50_rnd_b64_b1500     
TEST_LIST+=test_r10_lin_b64_b64       
TEST_LIST+=test_r10_lin_b1500_b1500   
TEST_LIST+=test_r10_lin_b64_b1500     
TEST_LIST+=test_r10_rnd_b64_b1500     

TOPDIR:=../../../.
IPDIR:=$(TOPDIR)/ip
LIBDIR:=$(TOPDIR)/lib

IPSRC:= \


LIBSRC:= \
	./gtype.sv \
	./xgmii_retransmit_32b32b_fifo/xgmii_retransmit_32b32b_fifo.sv \

TESTSRC:= \
	../../test/vsim_common/test_type.sv \
	./interface.sv \
	../../test/vsim_common/ethpack.sv \
	../../test/vsim_common/driver2xgmii.sv \
	../../test/vsim_common/monitor4xgmii.sv \
	../../test/vsim_common/ethpack_generator.sv \
	../../test/vsim_common/config.sv \
	../../test/vsim_common/scoreboard_pack.sv \
	./environment.sv \
	./dut.sv \
	./test.sv \

IPSRC:= $(addprefix $(IPDIR)/, $(IPSRC))
LIBSRC:= $(addprefix $(LIBDIR)/, $(LIBSRC))

clean:
	rm -rf transcript
	rm -rf vsim.wlf
	rm -rf wlft*
	rm -rf work/
	rm -rf fifo_xgmii_retransmit_32b32b/
	rm -rf ./log/*.log
	rm -rf ./log/*.vsim

VSIM_L:= -L work -L fifo_xgmii_retransmit_32b32b -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver 

run: $(TEST_LIST)
test_r100_lin_b64_b64      : ; @./prerun.sh test_r100_lin_b64_b64     ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b64_b64.log     $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r100_lin_b64_b64.vsim          ; ./postrun.sh test_r100_lin_b64_b64 
test_r100_lin_b1500_b1500  : ; @./prerun.sh test_r100_lin_b1500_b1500 ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b1500_b1500.log $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_lin_b1500_b1500.vsim      ; ./postrun.sh test_r100_lin_b1500_b1500
test_r100_lin_b64_b1500    : ; @./prerun.sh test_r100_lin_b64_b1500   ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b64_b1500.log   $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_lin_b64_b1500.vsim        ; ./postrun.sh test_r100_lin_b64_b1500
test_r100_rnd_b64_b1500    : ; @./prerun.sh test_r100_rnd_b64_b1500   ; vsim $(VSIM_L) -logfile ./log/test_r100_rnd_b64_b1500.log   $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_rnd_b64_b1500.vsim        ; ./postrun.sh test_r100_rnd_b64_b1500
test_r50_lin_b64_b64       : ; @./prerun.sh test_r50_lin_b64_b64      ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b64_b64.log      $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r50_lin_b64_b64.vsim           ; ./postrun.sh test_r50_lin_b64_b64
test_r50_lin_b1500_b1500   : ; @./prerun.sh test_r50_lin_b1500_b1500  ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b1500_b1500.log  $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_lin_b1500_b1500.vsim       ; ./postrun.sh test_r50_lin_b1500_b1500
test_r50_lin_b64_b1500     : ; @./prerun.sh test_r50_lin_b64_b1500    ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b64_b1500.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_lin_b64_b1500.vsim         ; ./postrun.sh test_r50_lin_b64_b1500
test_r50_rnd_b64_b1500     : ; @./prerun.sh test_r50_rnd_b64_b1500    ; vsim $(VSIM_L) -logfile ./log/test_r50_rnd_b64_b1500.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_rnd_b64_b1500.vsim         ; ./postrun.sh test_r50_rnd_b64_b1500
test_r10_lin_b64_b64       : ; @./prerun.sh test_r10_lin_b64_b64      ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b64_b64.log      $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r10_lin_b64_b64.vsim           ; ./postrun.sh test_r10_lin_b64_b64
test_r10_lin_b1500_b1500   : ; @./prerun.sh test_r10_lin_b1500_b1500  ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b1500_b1500.log  $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_lin_b1500_b1500.vsim       ; ./postrun.sh test_r10_lin_b1500_b1500
test_r10_lin_b64_b1500     : ; @./prerun.sh test_r10_lin_b64_b1500    ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b64_b1500.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_lin_b64_b1500.vsim         ; ./postrun.sh test_r10_lin_b64_b1500
test_r10_rnd_b64_b1500     : ; @./prerun.sh test_r10_rnd_b64_b1500    ; vsim $(VSIM_L) -logfile ./log/test_r10_rnd_b64_b1500.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_rnd_b64_b1500.vsim         ; ./postrun.sh test_r10_rnd_b64_b1500

compile_work:
	rm -rf work
	vlib work
	vlog -sv -lint $(LIBSRC) $(IPSRC) $(TESTSRC) +incdir+../../test/vsim_common/ top.sv 
	
compile_fifo_xgmii_retransmit_32b32b:
	rm -rf fifo_xgmii_retransmit_32b32b 
	vlib fifo_xgmii_retransmit_32b32b 
	
	vlog $(IPDIR)/fifo_xgmii_retransmit_32b32b/fifo_191/sim/fifo_xgmii_retransmit_32b32b_fifo_191_cz3yy4i.v -work fifo_xgmii_retransmit_32b32b 
	vlog $(IPDIR)/fifo_xgmii_retransmit_32b32b/sim/fifo_xgmii_retransmit_32b32b.v                           -work fifo_xgmii_retransmit_32b32b 

compile: compile_fifo_xgmii_retransmit_32b32b compile_work

all: clean compile 
	$(MAKE) run
