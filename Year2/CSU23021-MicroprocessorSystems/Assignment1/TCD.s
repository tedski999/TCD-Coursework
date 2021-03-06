; Program to calculate and demonstrate the factorial, storing the 64bit result in two registers
; Ted johnson, 2021.

	area    tcd,code,readonly
	export  __main

__main

	; An index into results space in rw memory
	ldr     r2,=results             ; i = &results

	; Calculate 5 factorial, write to results
	mov     r0,#5                   ; N = 5
	bl      fact                    ; result_lo, result_hi = fact(N)
	str     r0,[r2],#4              ; results[i] = result_hi, i += 4
	str     r1,[r2],#4              ; results[i] = result_lo, i += 4
	; The expected result is 120:
	; r0 = 0x0, r1 = 0x78, C = 0

	; Calculate 14 factorial, write to results
	mov     r0,#14                  ; N = 14
	bl      fact                    ; result_lo, result_hi = fact(N)
	str     r0,[r2],#4              ; results[i] = result_hi, i += 4
	str     r1,[r2],#4              ; results[i] = result_lo, i += 4
	; The expected result is 87,178,291,200:
	; r0 = 0x14, r1 = 0x4C3B2800, C = 0

	; Calculate 20 factorial, write to results
	mov     r0,#20                  ; N = 20
	bl      fact                    ; result_lo, result_hi = fact(N)
	str     r0,[r2],#4              ; results[i] = result_hi, i += 4
	str     r1,[r2],#4              ; results[i] = result_lo, i += 4
	; The expected result is 2,432,902,008,176,640,000:
	; r0 = 0x21C3677C, r1 = 0x82B40000, C = 0

	; Calculate 30 factorial, write to results
	mov     r0,#30                  ; N = 30
	bl      fact                    ; result_lo, result_hi = fact(N)
	str     r0,[r2],#4              ; results[i] = result_hi, i += 4
	str     r1,[r2]                 ; results[i] = result_lo
	; The expected result is 0 (An overflow error will have occurred, it's way off the scale!):
	; r0 = 0, r1 = 0, C = 1

stop	b       stop

	; fact subroutine
	; Computes the 64bit factorial of N
	; Parameters:
	;   r0 - N, a positive 32bit integer
	; Returns:
	;   r0 - The most significant 32bits of the 64bit integer result
	;   r1 - The least significant 32bits of the 64bit integer result
	; Notes:
	;   If an error occurs, the C flag will be set and zero is returned.
	;   Errors include the result not fitting in 64bits or a non-positive number was given for N.
	;   Otherwise, the C flag will be cleared.
fact	stmfd    sp!,{r2-r4,lr}

	; Take a copy of N called n, subtract one from N, let this be m.
	; m being zero is the recursions base case.
	; m being less than zero is due to a input N of 0 or less, which causes an error
	mov     r2,r0                   ; n = N
	subs    r0,r0,#1                ; m = N - 1
	beq     f_base                  ; if m == 0: goto f_base
	ble     f_error                 ; if m <= 0: goto f_error

	; The formula I'm using to calculate the factorial of N is N! = N * (N-1)!
	; We have N in r2 as n and N-1 in r0 as m.
	; To compute (N-1)! we perform recursion with r0 = N-1
	bl      fact                    ; m_fact_lo, m_fact_hi = fact(m)

	; Before we continue, let's first check if that call failed.
	; C will now be set if it failed, with the result already zeroed out.
	bcs     f_exit                  ; if C == 1: goto f_exit

	; At this point, m_fact_lo in r1 and m_fact_hi in r0 together form the 64bit result of (n-1)!
	; Now we must multiply this 64bit result by the 32bit value n located in r2.
	
	; To do this, we're going to perform 64bit multipication on both registers
	; and then add whatever overflowed when we multiplied m_fact_lo into result_hi.
	umull   r1,r3,r2,r1             ; result_lo, result_lo_overflow = n * m_fact_lo
	umull   r0,r4,r2,r0             ; result_hi, result_hi_overflow = n * m_fact_hi
	add     r0,r0,r3                ; result_hi += result_lo_overflow

	; Before we return this result, we need to verify that the result fit within the 64bits.
	; We can do this by checking if result_hi_overflow in r4 is zero.
	; If it does not, we should error. Else, we return with r0 = result_hi and r1 = result_lo.
	; We need to use cmn to not set the C flag as to not signal an error has occurred later on.
	cmn     r4,#0                   ; if result_hi_overflow != 0:
	bne     f_error                 ;     goto f_error
	
	; Generic return r0,r1 from subroutine
f_exit  ldmfd   sp!,{r2-r4,pc}          ; return result_lo, result_hi

	; Base case - Return 1, C flag cleared
	; Note result_hi in r0 is already zero by now, no point setting it again.
f_base	mov     r1,#1                   ; result_lo = 1
	cmn     r0,#0                   ; C = 0
	b       f_exit                  ; goto f_exit

	; Error case - Return 0, C flag set
f_error	mov     r1,#0                   ; result_lo = 0
	mov     r0,#0                   ; result_hi = 0
	cmp     r0,#0                   ; C = 1
	b       f_exit                  ; goto f_exit

	; Reserve rw space for results
	area    tcddata,data,readwrite
results	dcb     4*8                     ; 4x 8-byte spaces

	end
