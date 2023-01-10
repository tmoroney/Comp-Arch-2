include\masm32\include\masm32rt.inc
.data
.code
main:
  mov   ecx, 113       ; N (input)
  mov   eax, 0         ; sum = 0
  mov   ebx, 1         ; i = 1
forloop: 
  cmp   ebx, ecx       ; while (i <= N) {
  jg    endloop
  add   eax, ebx       ; sum = sum + i
  jo    overflow       ; check if number exceeds 32 bits (unsigned byte)
  add   ebx, 1         ; i++
  jmp     forloop      ; }

endloop:
  print str$(eax), 13, 10   ; print sum
  ret 0

overflow:
  print "Warning, result is too big", 1
  ret 1

end main

  