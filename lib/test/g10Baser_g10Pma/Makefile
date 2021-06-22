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

TEST_LIST+=test_r1_lin_b64_b64_linkup     
TEST_LIST+=test_r1_lin_b1500_b1500_linkup 
TEST_LIST+=test_r1_lin_b64_b1500_linkup   
TEST_LIST+=test_r1_rnd_b64_b1500_linkup   
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
   	./sync.sv \
	./tr_baser_wrapper/tr_baser_wrapper.sv \
	./tr_pma_wrapper/tr_pma_wrapper.sv \
	./align_rx_32b/align_rx_32b.sv \
	./blsync_rx/blsync_rx.sv \
	./pcs_rx_32b/pcs_rx_32b.sv \

TESTSRC:= \
	./../vsim_common/test_type.sv \
	./interface.sv \
	./../vsim_common/ethpack.sv \
	./../vsim_common/driver2xgmii.sv \
	./../vsim_common/monitor4xgmii.sv \
	./../vsim_common/ethpack_generator.sv \
	./../vsim_common/config.sv \
	./../vsim_common/scoreboard_pack.sv \
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
	rm -rf tr_rst/
	rm -rf tr_10g_baser/
	rm -rf tr_10g_pma/
	rm -rf tr_fpll/
	rm -rf pll_644_156/
	rm -rf ./log/*.log
	rm -rf ./log/*.vsim

VSIM_L:= -L work -L tr_10g_baser -L tr_10g_pma -L tr_rst -L tr_fpll -L pll_644_156 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L twentynm_ver -L twentynm_hssi_ver -L twentynm_hip_ver

run: $(TEST_LIST)
test_r1_lin_b64_b64_linkup     : ; @./prerun.sh test_r1_lin_b64_b64_linkup    ; vsim $(VSIM_L) -logfile ./log/test_r1_lin_b64_b64_linkup.log      $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=1 +generator_rate=1   +generator_count_packets=5   +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r1_lin_b64_b64_linkup.vsim     ; ./postrun.sh test_r1_lin_b64_b64_linkup    
test_r1_lin_b1500_b1500_linkup : ; @./prerun.sh test_r1_lin_b1500_b1500_linkup; vsim $(VSIM_L) -logfile ./log/test_r1_lin_b1500_b1500_linkup.log  $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=1 +generator_rate=1   +generator_count_packets=5   +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r1_lin_b1500_b1500_linkup.vsim ; ./postrun.sh test_r1_lin_b1500_b1500_linkup
test_r1_lin_b64_b1500_linkup   : ; @./prerun.sh test_r1_lin_b64_b1500_linkup  ; vsim $(VSIM_L) -logfile ./log/test_r1_lin_b64_b1500_linkup.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=1 +generator_rate=1   +generator_count_packets=5   +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r1_lin_b64_b1500_linkup.vsim   ; ./postrun.sh test_r1_lin_b64_b1500_linkup  
test_r1_rnd_b64_b1500_linkup   : ; @./prerun.sh test_r1_rnd_b64_b1500_linkup  ; vsim $(VSIM_L) -logfile ./log/test_r1_rnd_b64_b1500_linkup.log    $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=1 +generator_rate=1   +generator_count_packets=5   +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r1_rnd_b64_b1500_linkup.vsim   ; ./postrun.sh test_r1_rnd_b64_b1500_linkup  
test_r100_lin_b64_b64          : ; @./prerun.sh test_r100_lin_b64_b64         ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b64_b64.log           $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r100_lin_b64_b64.vsim          ; ./postrun.sh test_r100_lin_b64_b64 
test_r100_lin_b1500_b1500      : ; @./prerun.sh test_r100_lin_b1500_b1500     ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b1500_b1500.log       $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_lin_b1500_b1500.vsim      ; ./postrun.sh test_r100_lin_b1500_b1500
test_r100_lin_b64_b1500        : ; @./prerun.sh test_r100_lin_b64_b1500       ; vsim $(VSIM_L) -logfile ./log/test_r100_lin_b64_b1500.log         $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_lin_b64_b1500.vsim        ; ./postrun.sh test_r100_lin_b64_b1500
test_r100_rnd_b64_b1500        : ; @./prerun.sh test_r100_rnd_b64_b1500       ; vsim $(VSIM_L) -logfile ./log/test_r100_rnd_b64_b1500.log         $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=100 +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r100_rnd_b64_b1500.vsim        ; ./postrun.sh test_r100_rnd_b64_b1500
test_r50_lin_b64_b64           : ; @./prerun.sh test_r50_lin_b64_b64          ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b64_b64.log            $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r50_lin_b64_b64.vsim           ; ./postrun.sh test_r50_lin_b64_b64
test_r50_lin_b1500_b1500       : ; @./prerun.sh test_r50_lin_b1500_b1500      ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b1500_b1500.log        $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_lin_b1500_b1500.vsim       ; ./postrun.sh test_r50_lin_b1500_b1500
test_r50_lin_b64_b1500         : ; @./prerun.sh test_r50_lin_b64_b1500        ; vsim $(VSIM_L) -logfile ./log/test_r50_lin_b64_b1500.log          $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_lin_b64_b1500.vsim         ; ./postrun.sh test_r50_lin_b64_b1500
test_r50_rnd_b64_b1500         : ; @./prerun.sh test_r50_rnd_b64_b1500        ; vsim $(VSIM_L) -logfile ./log/test_r50_rnd_b64_b1500.log          $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=50  +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r50_rnd_b64_b1500.vsim         ; ./postrun.sh test_r50_rnd_b64_b1500
test_r10_lin_b64_b64           : ; @./prerun.sh test_r10_lin_b64_b64          ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b64_b64.log            $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=64   -do $(DO) > ./log/test_r10_lin_b64_b64.vsim           ; ./postrun.sh test_r10_lin_b64_b64
test_r10_lin_b1500_b1500       : ; @./prerun.sh test_r10_lin_b1500_b1500      ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b1500_b1500.log        $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=50  +generator_len_packet_type="lin" +generator_len_packet_start=1500 +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_lin_b1500_b1500.vsim       ; ./postrun.sh test_r10_lin_b1500_b1500
test_r10_lin_b64_b1500         : ; @./prerun.sh test_r10_lin_b64_b1500        ; vsim $(VSIM_L) -logfile ./log/test_r10_lin_b64_b1500.log          $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="lin" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_lin_b64_b1500.vsim         ; ./postrun.sh test_r10_lin_b64_b1500
test_r10_rnd_b64_b1500         : ; @./prerun.sh test_r10_rnd_b64_b1500        ; vsim $(VSIM_L) -logfile ./log/test_r10_rnd_b64_b1500.log          $(OPT) $(GUI_ENABLE) -nostdout top -sv_seed $(SEED) $(USR_OPTS) +test_force_linkdown=0 +generator_rate=10  +generator_count_packets=200 +generator_len_packet_type="rnd" +generator_len_packet_start=64   +generator_len_packet_finish=1500 -do $(DO) > ./log/test_r10_rnd_b64_b1500.vsim         ; ./postrun.sh test_r10_rnd_b64_b1500

compile_tr_10g_baser:
	rm -rf tr_10g_baser
	vlib tr_10g_baser

	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/alt_xcvr_resync.sv                           -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/alt_xcvr_arbiter.sv                          -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/twentynm_pcs.sv                              -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/twentynm_pma.sv                              -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/twentynm_xcvr_avmm.sv                        -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/mentor/twentynm_xcvr_native.sv                      -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/altera_xcvr_native_a10_functions_h.sv               -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/a10_avmm_h.sv                                       -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_pipe_retry.sv                       -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_avmm_csr.sv                         -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_prbs_accum.sv                       -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_odi_accel.sv                        -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_rcfg_arb.sv                         -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/altera_xcvr_native_pcie_dfe_params_h.sv             -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/pcie_mgmt_commands_h.sv                             -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/pcie_mgmt_functions_h.sv                            -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/pcie_mgmt_program.sv                                -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/pcie_mgmt_cpu.sv                                    -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/pcie_mgmt_master.sv                                 -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/altera_xcvr_native_pcie_dfe_ip.sv                   -work tr_10g_baser 
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/alt_xcvr_native_rcfg_opt_logic_vug4pii.sv           -work tr_10g_baser
	vlog -sv $(IPDIR)/tr_10g_baser/altera_xcvr_native_a10_191/sim/tr_10g_baser_altera_xcvr_native_a10_191_vug4pii.sv  -work tr_10g_baser
	vlog     $(IPDIR)/tr_10g_baser/sim/tr_10g_baser.v                                                                 -work tr_10g_baser 

compile_tr_10g_pma:
	rm -rf tr_10g_pma
	vlib tr_10g_pma

	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/alt_xcvr_resync.sv                         -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/alt_xcvr_arbiter.sv                        -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/twentynm_pcs.sv                            -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/twentynm_pma.sv                            -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/twentynm_xcvr_avmm.sv                      -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/mentor/twentynm_xcvr_native.sv                    -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/altera_xcvr_native_a10_functions_h.sv             -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/a10_avmm_h.sv                                     -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_pipe_retry.sv                     -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_avmm_csr.sv                       -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_prbs_accum.sv                     -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_odi_accel.sv                      -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_rcfg_arb.sv                       -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/altera_xcvr_native_pcie_dfe_params_h.sv           -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/pcie_mgmt_commands_h.sv                           -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/pcie_mgmt_functions_h.sv                          -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/pcie_mgmt_program.sv                              -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/pcie_mgmt_cpu.sv                                  -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/pcie_mgmt_master.sv                               -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/altera_xcvr_native_pcie_dfe_ip.sv                 -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/alt_xcvr_native_rcfg_opt_logic_zl6mkiq.sv         -work tr_10g_pma
	vlog -sv $(IPDIR)/tr_10g_pma/altera_xcvr_native_a10_191/sim/tr_10g_pma_altera_xcvr_native_a10_191_zl6mkiq.sv  -work tr_10g_pma
	vlog     $(IPDIR)/tr_10g_pma/sim/tr_10g_pma.v                                                                 -work tr_10g_pma

compile_tr_rst:
	rm -rf tr_rst
	vlib tr_rst

	vlog -sv $(IPDIR)/tr_rst/altera_xcvr_reset_control_191/sim/mentor/altera_xcvr_functions.sv       -work tr_rst
	vlog -sv $(IPDIR)/tr_rst/altera_xcvr_reset_control_191/sim/mentor/alt_xcvr_resync.sv             -work tr_rst
	vlog -sv $(IPDIR)/tr_rst/altera_xcvr_reset_control_191/sim/mentor/altera_xcvr_reset_control.sv   -work tr_rst
	vlog -sv $(IPDIR)/tr_rst/altera_xcvr_reset_control_191/sim/mentor/alt_xcvr_reset_counter.sv      -work tr_rst
	vlog     $(IPDIR)/tr_rst/sim/tr_rst.v                                                            -work tr_rst

compile_tr_fpll:
	rm -rf tr_fpll
	vlib tr_fpll

	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/mentor/twentynm_xcvr_avmm.sv           -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_resync.sv              -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/mentor/altera_xcvr_fpll_a10.sv         -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/a10_avmm_h.sv                          -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/alt_xcvr_native_avmm_nf.sv             -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_pll_embedded_debug.sv  -work tr_fpll
	vlog -sv $(IPDIR)/tr_fpll/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_pll_avmm_csr.sv        -work tr_fpll
	vlog     $(IPDIR)/tr_fpll/sim/tr_fpll.v                                                       -work tr_fpll

compile_pll_644_156:
	rm -rf pll_644_156
	vlib pll_644_156

	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/mentor/twentynm_xcvr_avmm.sv           -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_resync.sv              -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/mentor/altera_xcvr_fpll_a10.sv         -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/a10_avmm_h.sv                          -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/alt_xcvr_native_avmm_nf.sv             -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_pll_embedded_debug.sv  -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/altera_xcvr_fpll_a10_191/sim/mentor/alt_xcvr_pll_avmm_csr.sv        -work pll_644_156
	vlog -sv $(IPDIR)/pll_644_156/sim/pll_644_156.v                                                   -work pll_644_156

compile_work:
	rm -rf work
	vlib work
	vlog -sv -lint $(LIBSRC) $(TESTSRC) +incdir+../vsim_common/ top.sv 

compile: compile_tr_10g_baser compile_tr_10g_pma compile_tr_rst compile_tr_fpll compile_pll_644_156 compile_work

all: clean compile 
	$(MAKE) run
