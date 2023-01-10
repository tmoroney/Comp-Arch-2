include\masm32\include\masm32rt.inc
.data
.code
main:

  mov   eax, 8         ; input
  mov   ebx, 0         ; count = 0
divideNums:
  cmp   eax, 0         ; while (eax/10 != 0)
  je    printChar      ; {
  xor   edx, edx       ;   always set edx to 0 so it doesn't mess with division
  mov   ecx, 10        ;
  div   ecx            ;   eax = eax/10
  add   edx, 48        ;   char = remainder + 48
  push  edx            ;   push char to stack
  add   ebx, 1         ;   count++
  jmp   divideNums     ; }

printChar:
  cmp   ebx, 0         ; while (count != 0)
  je    done           ; {
  print esp, 0         ;   print num (as character) from stack
  pop   ecx            ;   pop off the stack
  sub   ebx, 1         ;   count--
  jmp   printChar      ; }

done:
  ret 0

end main

  