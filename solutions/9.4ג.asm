IDEAL
MODEL small
Stack 100h
DATASEG
ReturnAddress dw 0
max dw 0
min dw 0
tmp_max dw 0

CODESEG
proc setMaxAndMin
	pop [ReturnAddress]
	pop ax
	pop bx
	pop cx
	pop dx
	
	cmp ax, bx
	jg AXBigger
	jl BXBigger

AXBigger:
	push ax
	cmp cx, dx
	jg CXBigger
	jl DXBigger
	jmp finish

BXBigger:
	push bx
	cmp cx, dx
	jg CXBigger
	jl DXBigger
	jmp finish

CXBigger:
	pop [tmp_max]
	cmp [tmp_max], cx
	jg TmpMaxWon
	jl CxWon
	jmp finish

DXBigger:
	pop [tmp_max]
	cmp [tmp_max], dx
	jg TmpMaxWon
	jl DxWon
	jmp finish

TmpMaxWon:
	mov ax, [tmp_max]
	mov [max], ax
	jmp finish

CxWon:
	mov [max], cx
	jmp finish
	
DxWon:
	mov [max], dx
	jmp finish

finish:	
	push [ReturnAddress]
	ret
endp setMaxAndMin

start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 2
	mov bx, 21
	mov cx, 466
	mov dx, -5
	
	push ax
	push bx
	push cx
	push dx
	call setMaxAndMin
	
exit: 
	mov ax, 4c00h
	int 21h
END start
