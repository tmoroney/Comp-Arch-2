max3:
add r0, r26, r16       ; M = a
and r27, r16, r0, {C}  ; if (M > b)
jle check_c            ; {
add r0, r16, r1        ;     move M into result (replaces delay slot)
add r0, r27, r16       ;     M = b
check_c:               ; }
and r28, r16, r0, {C}  ; if (M > c)
jle found_max          ; {
add r0, r16, r1        ;     move M into result (replaces delay slot)
add r0, r28, r16       ;     M = c
found_max:             ; }
ret (r31)0             ; return r1
add r0, r16, r1        ; move M into result (replaces delay slot)

max4:
add r0, r26, r10       ; param 1 = a
add r0, r27, r11       ; param 2 = b
add r0, r28, r12       ; param 3 = c
call max3
add r0, r28, r11       ; param 2 = c  (replaces delay slot - the value of C doesn't need to be in r11 until we return from the function call)
add r0, r1,  r10       ; param 1 = max3(a,b,c)
add r0, r29, r11       ; param 3 = d
call max3
xor r0, r0, r0         ; delay slot   (no operation can be moved to this position)
ret (r31)0             ; return max3(max3(a,b,c),c,d)
xor r0, r0, r0         ; delay slot   (no operation can be moved to this position)

main:
add r0, 10, r10        ; a = 10
add r0, 15, r11        ; b = 15
add r0, 12, r12        ; c = 12
add r0, 23, r13        ; d = 23
call max4
xor r0, r0, r0         ; delay slot   (no operation can be moved to this position)
ret (r31)0
xor r0, r0, r0         ; delay slot   (no operation can be moved to this position)
