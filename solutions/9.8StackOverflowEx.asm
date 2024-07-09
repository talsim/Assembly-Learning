IDEAL
MODEL small
STACK 100h
DATASEG
	msg1 db 'Please enter your name, press enter to finish',13,10,'$'
	msg2 db 13,10,'Program finished$'
	msg3 db 13,10,'Here be dragons$'
CODESEG
proc GetName
	; Get user input and store it on the stack
	push bp
	mov bp, sp
	sub sp, 10 ; Allocate a buffer of 10 bytes on the stack
	mov di, sp
	mov ah, 1
	mov cl, 0  ; init char counter -- ADDED BY TAL SIMHAYEV
	xor bx, bx 
get_char:
	int 21h
	cmp al, 13 ; Is it the 'enter' key?
	je quit_proc
	; OR if we have read 10 chars already (to avoid stack overflow) -- ADDED BY TAL SIMHAYEV
	cmp cl, 10  ; Did we read 10 chars? -- ADDED BY TAL SIMHAYEV
	je quit_proc
	mov [ss:di+bx], al ; Copy user input to the buffer on the stack
	inc bx
	inc cl  ; char counter -- ADDED BY TAL SIMHAYEV
	jmp get_char
quit_proc:
	add sp, 10 ; De-allocate buffer
	pop bp
	ret
endp GetName

start:
	mov ax, @data
	mov ds, ax
	mov ah, 9
	mov dx, offset msg1
	int 21h
	call GetName
	mov ah, 9
	mov dx, offset msg2
	int 21h
exit:
	mov ax, 4c00h
	int 21h
	; This code should not be reached at all, as the program should have
	; already exited
	nops db 20E8h dup (90h) ; Fill a part of the memory with NOP (90h)-
	; NOP - a command which does nothing (No Operation)
	mov ah, 9
	mov dx, offset msg3
	int 21h
	jmp exit
END start