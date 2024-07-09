IDEAL
MODEL small
STACK 100h
DATASEG

CODESEG
proc printHelloWorld
	push bp
	mov bp, sp
	
	push ax
	push dx
	
	call printHello
	call printWorld
	
	pop dx
	pop ax
	
	pop bp
	ret
endp printHelloWorld

proc printHello
	push bp
	mov bp, sp
	
	push ax
	push dx
	
	mov dl, 'H'
	mov ah, 2
	int 21h
	
	mov dl, 'E'
	mov ah, 2
	int 21h
	
	mov dl, 'L'
	mov ah, 2
	int 21h
	
	mov dl, 'L'
	mov ah, 2
	int 21h
	
	mov dl, 'O'
	mov ah, 2
	int 21h
	
	call printNewline
	
	pop dx
	pop ax
	
	pop bp
	ret
endp

proc printWorld
	push bp
	mov bp, sp
	
	push ax
	push dx
	
	mov dl, 'W'
	mov ah, 2
	int 21h
	
	mov dl, 'O'
	mov ah, 2
	int 21h
	
	mov dl, 'R'
	mov ah, 2
	int 21h
	
	mov dl, 'L'
	mov ah, 2
	int 21h
	
	mov dl, 'D'
	mov ah, 2
	int 21h
	
	pop dx
	pop ax
	
	pop bp
	ret
endp

proc printNewline
	push bp
	mov bp, sp
	
	mov dl, 10
	mov ah, 2
	int 21h
	
	mov dl, 13
	mov ah, 2
	int 21h
	
	pop bp
	ret
endp

start:
	mov ax, @data
	mov ds, ax
	
	call printHelloWorld
	
exit:
	mov ax, 4c00h
	int 21h

END start