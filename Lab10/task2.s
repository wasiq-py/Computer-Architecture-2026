addi x28, x0, 5
addi x2,x0,511
addi x5,x0,768
addi x6,x0,512
sw x28, 0(x5)
INPUT_WAIT:
sw x0,0(x6)
POLL_SWITCH:
lw x11,0(x5)
beq x11,x0,POLL_SWITCH
add x10,x11,x0
jal x1,COUNTDOWN
beq x0,x0,INPUT_WAIT
COUNTDOWN:
addi x2,x2,-8
sw x1,4(x2)
sw x12,0(x2)
add x12,x10,x0
COUNT_LOOP:
sw x12,0(x6)
beq x12,x0,COUNT_DONE
addi x12,x12,-1
addi x13,x0,3
DELAY:
addi x13,x13,-1
bne x13,x0,DELAY
beq x0,x0,COUNT_LOOP
COUNT_DONE:
sw x0,0(x6)
lw x12,0(x2)
lw x1,4(x2)
addi x2,x2,8
jalr x0,0(x1)

end:
    j end