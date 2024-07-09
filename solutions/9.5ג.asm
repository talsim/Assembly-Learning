IDEAL
MODEL small
Stack 100h
DATASEG
ReturnAddress dw 0
var1 db 5
var2 db 2


CODESEG
proc swap
	pop [ReturnAddress]

	pop bx  ; var2 pointer
	pop di  ; var1 pointer
	
	mov al, [byte ptr bx]  ; tmp var2
	mov dl, [byte ptr di]
	mov [byte ptr bx], dl  ; var2 = var1
	mov [byte ptr di], al  ; var1 = var2_tmp

	push [ReturnAddress]
	ret
endp swap

start:
	mov ax, @data
	mov ds, ax
	
	push offset var1
	push offset var2
	call swap
	
	
exit: 
	mov ax, 4c00h
	int 21h
END start