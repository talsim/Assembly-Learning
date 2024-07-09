IDEAL
MODEL small
Stack 100h
DATASEG
var1 db 4
var2 db 5

CODESEG
proc swap
	push bp
	mov bp, sp
	
	mov bx, [word ptr bp+4]  ; var2 pointer
	mov di, [word ptr bp+6]  ; var1 pointer
	
	mov al, [byte ptr bx]  ; al = var2 tmp (var2 value)
	mov dl, [byte ptr di]  ; dl = var1 value (dereference)
	
	; actual swap
	mov [byte ptr bx], dl  ; var2 = var1
	mov [byte ptr di], al  ; var1 = var2_tmp
	
	pop bp
	ret 4
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