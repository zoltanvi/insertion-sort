INCLUDE Irvine32.inc

;                  __INSERTION SORTING__
;       The program is accepting integer numbers (except 0!)
;       from the user, separated with ENTERs.
;       It executes the sorting when gets 0 (zero) as an input.
;       Example: 
;       ####input:
;         > 2
;         > -50
;         > 7
;         > 61
;        ####output:
;        "The sorted array: [ -50, 2, 7, 61 ]"

.data
	prompt		BYTE				"Insertion sorting", 0ah, 0ah, "Enter the elements of the array! (0): execute!", 0ah, 0
	prompt2		BYTE				0ah, "The sorted array: [ ", 0
	comma		BYTE				", ", 0
	endtext		BYTE				" ]", 0ah, "Do you want to sort another array? (1): yes, (anything else): no", 0ah, 0
	ARRAYLEN 		DWORD 			0
	leftsign			SDWORD			-999
	THEARRAY 		SDWORD	100 DUP	(?)
	
.code

main proc

loop_0:
	mov edx, offset prompt
	call WriteString

	call inputreader
	call sorter

	mov edx, offset prompt2
	call WriteString
	
	call printout

	mov edx, offset endtext
	call WriteString

	call ReadInt
	CMP EAX, 1
	JE loop_0



	INVOKE	ExitProcess,0

main endp

; ===================================== inputreader PROC ==============================================

inputreader proc					
	MOV ECX, 0
	MOV ESI, offset THEARRAY
loop_1:
	call ReadInt
	CMP EAX, 0
	JE end_1
	INC ECX
	MOV [ESI], EAX
	ADD ESI, 4
	JMP loop_1					
end_1:
	MOV [ARRAYLEN], ECX
ret
inputreader endp

; ===================================== printout PROC ==============================================

printout proc	
	MOV ESI, offset THEARRAY
	MOV ECX, ARRAYLEN
loop_2:	
	MOV EAX, [ESI]
	call WriteInt					
	MOV EDX, offset comma
	call WriteString
	ADD ESI, 4
	DEC ECX
	CMP ECX, 1
	JNE loop_2
	MOV EAX, [ESI]
	call WriteInt
ret
printout endp

; ===================================== swapthose PROC ==============================================

swapthose proc
loop_3:
	MOV EBX, [ESI-4]
	CMP EBX, [leftsign]
	JE	endlabel	
	MOV EBX, [ESI]
	CMP EBX, [ESI-4]
	JL lessthan						
	JMP endlabel
lessthan:
	XCHG EBX, [ESI-4]
	MOV [ESI], EBX
	SUB ESI, 4
	JMP loop_3
endlabel:	

ret
swapthose endp

; ===================================== sorter PROC ==============================================

sorter proc
	MOV ECX, [ARRAYLEN]
	MOV EDI, offset THEARRAY
loop_4:
	MOV ESI, EDI
	call swapthose
	ADD EDI, 4
	LOOP loop_4
endit:
ret
sorter endp

.stack
			dw		100	dup	(?)

end main