IDEAL
MODEL small
Stack 100h
DATASEG
ReturnAddress dw 0

CODESEG
proc print1X
	mov dl, 'X'
	mov ah, 2h
	int 21h
	
	ret
endp print1X

proc printXAlot
	pop [ReturnAddress]
	pop cx  ; the paramater will be popped into cx
	cmp cx, 0h
	jle justExit
	
printLoop:
	call print1X
	
	loop printLoop

justExit:
	push [ReturnAddress]
	ret

endp printXAlot

start:
	mov ax, @data
	mov ds, ax
	
	mov bx, 5
	push bx  ; print 10 times 'X' ! :D
	call printXAlot
	
exit: 
	mov ax, 4c00h
	int 21h
END start
