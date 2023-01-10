includelib ucrt
includelib legacy_stdio_definitions.lib
printf proto
ExitProcess proto


.data
N dq 2
message db "result in eax: %d", 0

.data?
x dq ?


.code

my_sum4 proc
    ;creating stack frame
    push rbp            
    mov  rbp, rsp       
    ;local variables
    sub  rsp, 16

    xor  rax, rax       ; x = 0
    cmp  rcx, 0         ; if (a <= 0)
    jle  endFunc        ;   return x;
    mov  rax, rcx
    dec  rcx            ; x = a--
    cmp  rdx, 0         ; if (b >= 0)
    jl   checkC         ; {
    add  rax, rdx       ;   x += b--
    dec  rdx            ;   b--
checkC:                 ; }
    cmp  r8, 0          ; if (c >= 0)
    jl   checkD         ; {
    add  rax, r8        ;   x += c--
    dec  r8             ;   c--
checkD:                 ; }
    cmp  r9, 0          ; if (d >= 0)
    jl   recursiveCall  ; {
    add  rax, r9        ;   x += d--
    dec  r9             ;   d--
recursiveCall:
    push rax ; store x in local variable space
    sub  rsp, 40       ; shadow space
    call my_sum4       ; my_sum4(a,b,c,d)
    add  rsp, 40       ; is the stack aligned?
    mov  r10, rax      ; result
    pop  rax
    add  rax, r10      ; return(X + my_sum4(a,b,c,d))

endFunc:
    add rsp, 16
    pop rbp            ;cleaning the stack
    ret 0
my_sum4 endp


my_sum4_wrapper proc
    xor  rax, rax

    mov  rcx, rcx       ; a = N  (just for clarity)
    mov  rdx, rcx
    dec  rdx            ; b = N-1
    mov  r8, rdx
    dec  r8             ; c = N-2
    mov  r9, r8
    dec  r9             ; d = N-3
    sub  rsp, 40        ; shadow space
    call my_sum4

    add  rsp, 40        ; is the stack aligned?
    ret 0
my_sum4_wrapper endp

main proc
    mov  rcx, 5                ; N = 5 (parameter is 8 bytes)
    sub  rsp, 40                ; shadow space
    call my_sum4_wrapper        ; my_sum4_wrapper(N)
    add  rsp, 40                ; is the stack aligned?

	push rax
	pop x
	lea rcx, message
	mov rdx, x
	call printf
    call ExitProcess
	ret 0
main endp

END