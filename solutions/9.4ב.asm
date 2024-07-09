IDEAL
MODEL small
Stack 100h
DATASEG
ReturnAddress dw 0

CODESEG
proc printA
	mov dl, 'A'
	mov ah, 2h
	int 21h
	
	ret
endp printA

proc printB
	mov dl, 'B'
	mov ah, 2h
	int 21h
	
	ret
endp printB

proc printC
	mov dl, 'C'
	mov ah, 2h
	int 21h
	
	ret
endp printC

proc compareNumbers
	pop ReturnAddress
	
	pop bx
	pop ax
	cmp ax, bx
	
	jg doprintA
	jl doPrintB
	je doPrintC
	
doPrintC:
	call printC
	jmp finish
doPrintB:
	call printB
	jmp finish
doPrintA:
	call printA
	jmp finish

finish:
	push ReturnAddress
	ret
endp compareNumbers

start:
	mov ax, @data
	mov ds, ax
	
	mov ax, -14
	mov bx, -13
	push ax
	push bx
	call compareNumbers
	
exit: 
	mov ax, 4c00h
	int 21h
END start
