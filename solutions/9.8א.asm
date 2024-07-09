IDEAL
MODEL small
Stack 100h
DATASEG
arr_size equ 31
arr db arr_size dup (4)
sum db 0

CODESEG
arr_size_param equ [word ptr bp+8]
;; sum = [bp+6]
;; arr pointer = [bp+4]
proc sumArray
	push bp
	mov bp, sp
	sub sp, 2  ; allocating memory for local variable index
	
	push ax  ; for dereferencing the array pointer
	push si
	mov si, [word ptr bp+6]  ; setting a reference to sum
	push bx
	mov bx, [word ptr bp+4]  ; setting array iterator
	push cx  ; save cx
	mov cx, arr_size_param  ; setting loop counter
	push di  ; for indexing
	xor di, di  ; index = 0
sumLoop:
	mov al, [byte ptr bx + di] ; dereferencing
	add [byte ptr si], al  ; sum += array element
	inc di  ; incrementing the index
	loop sumLoop

	pop di
	pop cx
	pop bx
	pop si
	pop ax
	
	add sp, 2  ; deallocating memory for index
	pop bp
	ret 6
endp sumArray

start:
	mov ax, @data
	mov ds, ax
	
	mov [arr+24], 93
	mov [arr+11], 11
	push arr_size
	push offset sum
	push offset arr
	call sumArray  ; sum will be = 220 (0xDC)
	
	
exit: 
	mov ax, 4c00h
	int 21h
END start