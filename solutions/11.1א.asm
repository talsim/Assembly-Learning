IDEAL
MODEL small
STACK 100h
DATASEG

CODESEG
proc getChar
	push bp
	mov bp, sp
	
	push ax
	mov ah, 1  ; read character
	int 21h
	
	; now al holds the char
	push bx
	mov bl, al
	
	mov ah, 1
	int 21h
	cmp bl, al
	jg BlBigger
	jmp finish

BlBigger:
	mov cx, 241

finish:
	pop bx
	pop ax
	pop bp
	ret
endp getChar

start:
	mov ax, @data
	mov ds, ax
	
	call getChar
	
exit:
	mov ax, 4c00h
	int 21h

END start