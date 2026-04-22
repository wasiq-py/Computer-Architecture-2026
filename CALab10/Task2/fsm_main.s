# =========================================
# Lab 10 - Task 2: FSM Countdown Program
# Reads switches, displays countdown on LEDs
# Stack used to save ra and counter register
# =========================================

# set up test value and memory addresses
addi x28, x0, 7
addi x2, x0, 511
addi x5, x0, 768
addi x6, x0, 512

# store the initial 7 to the switches for simulation
sw x28, 0(x5)

WAIT_STATE:
    # clear LEDs before we start waiting
    sw x0, 0(x6)

SWITCH_POLL:
    # read the switch value into x11
    lw x11, 0(x5)
    
    # if switches still zero keep polling
    beq x11, x0, SWITCH_POLL
    
    # copy the switch value to x10 for the subroutine
    add x10, x11, x0
    
    # jump to the countdown subroutine
    jal x1, START_COUNT
    
    # after we get back, unconditionally go wait again
    jal x0, WAIT_STATE

START_COUNT:
    # save ra and x12 before doing anything
    addi x2, x2, -8
    sw x1, 4(x2)
    sw x12, 0(x2)
    
    # x12 is our working counter, copy x10 into it
    add x12, x10, x0

COUNT_LOOP:
    # display current counter value on LEDs
    sw x12, 0(x6)
    
    # if we reached 0, jump to finish
    beq x12, x0, COUNT_DONE
    
    # decrement the counter
    addi x12, x12, -1
    
    # load 4 into x13 for the delay
    addi x13, x0, 4

DELAY_LOOP:
    # delay of 4 so LEDs are visible on hardware
    addi x13, x13, -1
    bne x13, x0, DELAY_LOOP
    
    # jump back to update LEDs and check again
    jal x0, COUNT_LOOP

COUNT_DONE:
    # done counting, turn off LEDs
    sw x0, 0(x6)
    
    # clean up stack and go back
    lw x12, 0(x2)
    lw x1, 4(x2)
    addi x2, x2, 8
    
    # return to the main FSM loop
    jalr x0, 0(x1)

# =========================================
# Machine Code (hex, one instruction per line):
# 0x00700E13  -> addi x28, x0, 7
# 0x1FF00113  -> addi x2, x0, 511
# 0x30000293  -> addi x5, x0, 768
# 0x20000313  -> addi x6, x0, 512
# 0x01C2A023  -> sw x28, 0(x5)
# 0x00032023  -> sw x0, 0(x6)             (WAIT_STATE)
# 0x0002A583  -> lw x11, 0(x5)            (SWITCH_POLL)
# 0xFE058EE3  -> beq x11, x0, SWITCH_POLL
# 0x00058533  -> add x10, x11, x0
# 0x008000EF  -> jal x1, START_COUNT
# 0xFEDFF06F  -> jal x0, WAIT_STATE
# 0xFF810113  -> addi x2, x2, -8          (START_COUNT)
# 0x00112223  -> sw x1, 4(x2)
# 0x00C12023  -> sw x12, 0(x2)
# 0x00050633  -> add x12, x10, x0
# 0x00C32023  -> sw x12, 0(x6)            (COUNT_LOOP)
# 0x00060C63  -> beq x12, x0, COUNT_DONE
# 0xFFF60613  -> addi x12, x12, -1
# 0x00400693  -> addi x13, x0, 4
# 0xFFF68693  -> addi x13, x13, -1        (DELAY_LOOP)
# 0xFE069EE3  -> bne x13, x0, DELAY_LOOP
# 0xFE9FF06F  -> jal x0, COUNT_LOOP
# 0x00032023  -> sw x0, 0(x6)             (COUNT_DONE)
# 0x00012603  -> lw x12, 0(x2)
# 0x00412083  -> lw x1, 4(x2)
# 0x00810113  -> addi x2, x2, 8
# 0x00008067  -> jalr x0, 0(x1)
# =========================================
