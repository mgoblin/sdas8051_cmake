; Blink LED on P10 pin

.module blink
.optsdcc -mmcs51 --model-small --debug

.area CSEG	(CODE)


start::
	mov P1, #0x00	; Initialize Port 1 (all LEDs off)
main::
	acall delay	; Call delay subroutine
	cpl P1.0	; Invert LED pin value (0 or 1)
	sjmp main

;=====================================================================
; Delay subroutine
; Wait for ~1 second
; Change R5, R6, R7 registrers
; Subroutine caller should save/restore used register if needed
;=====================================================================
delay:
	mov R7, #0x1f
d1:	mov R6, #0xff
d2:	mov R5, #0xff
	
d3:	djnz R5, d3
	djnz R6, d2
	djnz R7, d1
	
	ret
