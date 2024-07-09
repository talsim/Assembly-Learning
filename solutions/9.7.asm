IDEAL
MODEL small
Stack 100h
DATASEG

CODESEG
LocalX equ [bp-2h]
LocalY equ [bp-4h]
LocalZ equ [bp-6h]

proc XYZ
	push bp
	mov bp, sp
	sub sp, 6  ; allocate space for local variables
	
	push ax
	mov ax, [bp+4h]
	mov LocalX, ax
	
	mov ax, [bp+6h]
	mov LocalY, ax
	
	mov ax, [bp+8h]
	mov LocalZ, ax
	
	pop ax
	add sp, 6  ; deallocate space for local variables
	pop bp
	ret 6
endp XYZ

start:
	mov ax, @data
	mov ds, ax
	
	push 0002h
	push 0071h
	push 0649h
	call XYZ
	
	
exit: 
	mov ax, 4c00h
	int 21h
END start