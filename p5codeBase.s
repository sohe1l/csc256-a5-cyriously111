.data
  expVal23:    .asciiz  "Expected Value : 23  Your Value : "
  expVal21:    .asciiz  "Expected Value : 21  Your Value : "
  endl:        .asciiz  "\n"

.text

# #
# int getDigit(int number);
# List Used Registers Here:
#
# $a0 -> number
# $t0 -> sum
# $t1 -> 10
# $t2 -> temp for remainder
# $t3 -> temp for quotient
#
# #
getDigit:

li $t0, 0
li $t1, 10
bge $a0, $t1, else1
add $t0, $0, $a0
j endGetDigit
else1:
rem $t2, $a0, $t1
div $t3, $a0, $t1
add $t0, $t2, $t3
endGetDigit:
move $v0, $t0
jr $ra





# #
# int sumOfDoubleEvenPlace(int number);
# List Used Registers Here:
# sum --> $s0
# digit --> $s1
# $t8 --> copy of number arg
# $t9 --> temp for digit*2
# 
# #
sumOfDoubleEvenPlace:
addi $sp, $sp, -20
sw $s3, ($sp)
sw $s2, 4($sp)
sw $s1, 8($sp)
sw $s0, 12($sp)
sw $ra, 16($sp)


li $s0, 0 # sum
li $s1, 0 # digit
li $t8, 0 # number
li $t1, 10 # 10
move $t8, $a0
div $t8, $t8, $t1

ble $t8, $0, function_endwhile
function_while:
rem $s1, $t8, $t1 # digit = (number % 10);
mul $t9, $s1, 2 # temp for digit*2

move $a0, $t9 # set up args for getDigit
jal getDigit # call getDigit
add $s0, $s0, $v0 # sum += getDigit's return

div $t8, $t8, $t1
div $t8, $t8, $t1 # didn't want to make another variable for 100, so i divided by 10 twice

bgt $t8, $t0, function_while

function_endwhile:
move $v0, $s0



lw $ra, 16($sp)
lw $s0, 12($sp)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $s3, ($sp)
addi $sp, $sp, 20

jr $ra



main:
  li $s0, 89744563  # int test1 = 89744563;
  li $s1, 98756421  # int test2 = 98756421;
  li $s2, 0         # int result1 = 0;
  li $s3, 0         # int result2 = 0;


  # code for first function call

  add $a0, $0, $s0
  jal sumOfDoubleEvenPlace
  add $s2, $0, $v0 

  la   $a0, expVal23     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s2       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

   # code for first function call

  add $a0, $0, $s1
  jal sumOfDoubleEvenPlace
  add $s3, $0, $v0 

  la   $a0, expVal21     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s3       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

  li $v0, 10
  syscall
