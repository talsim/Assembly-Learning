IDEAL
MODEL small
STACK 100h
DATASEG
num1 dw 0
num2 dw 0

CODESEG
proc get2Numbers  ; void get2Numbers(int* num1, int* num2)
	push bp
	mov bp, sp
	
	push ax
	push bx
	mov ah, 1  ; get first number (0 - 9)
	int 21h
	
	mov bx, [bp+4]  ; register bx = *num1
	sub al, '0'  ; convert to the actual number
	mov [byte ptr bx], al
	
	mov ah, 1  ; get second number
	int 21h
	
	mov bx, [bp+6]
	sub al, '0'
	mov [byte ptr bx], al
	
	pop bx
	pop ax
	pop bp
	ret
endp get2Numbers


proc printBiggest  ; void printBiggest(int num1, int num2)
	push bp
	mov bp, sp
	
	push ax
	push dx
	
	mov ax, [bp+4]  ; num1
	mov bx, [bp+6]  ; num2
	
	cmp ax, bx
	jg AXBIGGER
	jmp BXBIGGER
	
AXBIGGER:
	push ax
	call print
	add sp, 2
	jmp FINISH
	
BXBIGGER:
	push bx
	call print
	add sp, 2
	
FINISH:
	pop dx
	pop ax
	pop bp
	ret
endp printBiggest


proc print  ; void print(int n)
	push bp
	mov bp, sp
	
	push dx
	push ax
	
	mov ah, 2
	mov dl, 10
	int 21h
	
	mov ah, 2
	mov dl, 13
	int 21h
	
	mov ah, 2
	mov dl, [byte ptr bp+4]  ; n paramater
	add dl, '0'  ; convert to the ASCII code of the number
	int 21h
	
	pop ax
	pop dx
	pop bp
	ret
endp print
start:
	mov ax, @data
	mov ds, ax
	
	push offset num2  ; pass by reference
	push offset num1
	call get2Numbers
	add sp, 4  ; caller cleaning up
	
	push [num2]  ; pass by value
	push [num1]
	call printBiggest
	
exit:
	mov ax, 4c00h
	int 21h

END start