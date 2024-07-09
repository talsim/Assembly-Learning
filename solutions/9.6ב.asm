IDEAL
MODEL small
Stack 100h
DATASEG
var1 dw 5
var2 dw 648
max dw -1

CODESEG
proc setMaxNum
	push bp  ; saving the base pointer on stack
	mov bp, sp
	
	mov bx, [bp+4]  ; pointer to the max paramater
	var2Param equ [bp+6]  ; var2 paramater
	var1Param equ [bp+8]  ; var1 paramater
	
	mov ax, var2Param
	cmp var1Param, ax
	jg var1Bigger
	
	mov [word ptr ds:bx], ax
	jmp finish
	
var1Bigger:
	mov ax, var1Param
	mov [word ptr ds:bx], ax
	
finish:
	pop bp
	ret 6
endp setMaxNum

start:
	mov ax, @data
	mov ds, ax
	
	push [var1]
	push [var2]
	push offset max
	
	call setMaxNum
	
	
exit: 
	mov ax, 4c00h
	int 21h
END start