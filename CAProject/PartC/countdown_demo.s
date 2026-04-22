# =========================================
# Project Part C: Loop Countdown Demo
# Counts from 15 down to 0 on LEDs, repeats
# No switch input needed - runs automatically
# =========================================

    addi x6, x0, 512     # x6 = LED address
    addi x7, x0, 15      # x7 = starting count value

OUTER_LOOP:
    add x8, x7, x0       # x8 is our working counter this round

COUNT_DOWN:
    sw x8, 0(x6)         # show current value on LEDs
    beq x8, x0, RESET_COUNT  # if zero, restart
    addi x8, x8, -1      # decrement working counter
    addi x9, x0, 6       # load delay counter

INNER_DELAY:
    addi x9, x9, -1      # delay so each step is visible
    bne x9, x0, INNER_DELAY
    jal x0, COUNT_DOWN   # go back to top of countdown

RESET_COUNT:
    sw x0, 0(x6)         # clear LEDs briefly
    jal x0, OUTER_LOOP   # back to top, start from 15 again

# =========================================
# Machine Code (hex, one instruction per line):
# 0x20000313  -> addi x6, x0, 512
# 0x00F00393  -> addi x7, x0, 15
# 0x00038433  -> add x8, x7, x0            (OUTER_LOOP)
# 0x00832023  -> sw x8, 0(x6)              (COUNT_DOWN)
# 0x00040C63  -> beq x8, x0, RESET_COUNT
# 0xFFF40413  -> addi x8, x8, -1
# 0x00600493  -> addi x9, x0, 6
# 0xFFF48493  -> addi x9, x9, -1           (INNER_DELAY)
# 0xFE049EE3  -> bne x9, x0, INNER_DELAY
# 0xFE9FF06F  -> jal x0, COUNT_DOWN
# 0x00032023  -> sw x0, 0(x6)              (RESET_COUNT)
# 0xFDDFF06F  -> jal x0, OUTER_LOOP
# =========================================
