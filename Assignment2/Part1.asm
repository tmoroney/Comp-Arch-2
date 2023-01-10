.386                       ; assembly is built on the prototype of intel's 386 machine
.model flat, stdcall       ; defines the call mode you want
option casemap:none        ; case sensitive
include \masm32\include\masm32rt.inc

.data
    msg db "The result is: %d", 13, 10, 0
    err db "Error, input must be greater than or equal to 0 ", 13, 10, 0

.data?
    x dd ?  ; data segment without initialization (temporary area for storage)

.code

main:
    
    mov   ecx, 10              ; N (input)
    call  my_factorial
    
    push eax
    pop x
    printf(addr msg, x)   ; print result
    
    add esp, 8
    ret 0

my_factorial PROC
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]    ; !! correction -- didn't preserve ebx
    ; Push here any other registers
    ; that need preserving
    cmp   ecx, 0          ; if (N < 0)
    jl    print_err        ;   print(error)
    mov   eax, 1          ;
    cmp   ecx, 0          ; if (N == 0)
    je    end_func        ;   return eax (1)
    push  ecx
    dec   ecx             ; ecx = N-1
    call  my_factorial
    pop   ecx
    mul   ecx             ; N*my_factorial(N-1)
    ; here I would restore any other register
    ; that needs preserving

end_func:
    pop ebx               ; !! correction -- didn't preserve ebx
    mov esp, ebp          ; clearing local variables
    pop ebp               ; restoring ebp
    ret 0

print_err:

    printf(addr err)
    ret 0

my_factorial ENDP

end main

END