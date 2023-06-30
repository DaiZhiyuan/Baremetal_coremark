# Baremetal_coremark
This project demonstrates the coremark benchmark in a baremetal environment.

# Running coremark on Arm FVP

```shell
● FVP_Base_RevC-2xAEMvA pre-build/coremark.axf
terminal_0: Listening for serial connection on port 5000
terminal_1: Listening for serial connection on port 5001
terminal_2: Listening for serial connection on port 5002
terminal_3: Listening for serial connection on port 5003
2K performance run parameters for coremark.
CoreMark Size    : 666
Total ticks      : 1798
Total time (secs): 17.980000
Iterations/Sec   : 1668.520578
Iterations       : 30000
Compiler version : Arm Compiler for Embedded 6.18
Compiler flags   : -O1
Memory location  : STACK
seedcrc          : 0xe9f5
[0]crclist       : 0xe714
[0]crcmatrix     : 0x1fd7
[0]crcstate      : 0x8e3a
[0]crcfinal      : 0x5275
Correct operation validated. See README.md for run and reporting rules.
CoreMark 1.0 : 1668.520578 / Arm Compiler for Embedded 6.18 -O1 / STACK

Info: /OSCI/SystemC: Simulation stopped by user.
```
