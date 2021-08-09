## Overview
This repo is a experiment of writing simple and low latency 10GBASE-R PCS for receiving and transmitting Ethernet packets on full 10Gbit/s speed without drop. 
PCS architecture based on IEEE Std 802.3-2008 standard and testing on Intel FPGA. Anyway, it can be easily ported for another vendors, as used standard input and output interfaces. XGMII and PMA interfaces has 32 bit width 

<p align="center">
  <img src="./pcs32.PNG">
</p>

## Pcs RX
### Synchronization
The PCS maps XGMII signals into 66-bit blocks, and vice versa, using a 64B/66B coding scheme. 66bit block consist from 2 bit header and 64 bit data field. From PMA we receive raw 32 bit words and sync block need for extract and align header and data bits. The scheme of alignment is described in standard.  
## Pcs TX
## Verification
## Resources
## Latency
