BR      main

; Arman Petrosyan
; Fibonacci Sequence
; CSIS 165, Lab 2A

; parameters and locals for fib function
temp:    .EQUATE 0 ; #2d
n:       .EQUATE 4 ; #2d
retval:  .EQUATE 6 ; #2d

; main locals
num:     .EQUATE 0 ; #2d

; data section
prompt:  .ASCII  "Range num? \x00"

fib:     SUBSP   2,i    ; push #temp
         LDWA    n,s    ; get param
         STWA    temp,s
         LDWA    n,s
         CPWA    0,i
         BRLT    lesst0
         CPWA    2,i
         BRLE    lesst2

; recursive case
         LDWA    temp,s
         SUBA    1,i
         SUBSP   4,i    ; push #retval #n 
         STWA    0,s
         CALL    fib
         ADDSP   4,i    ; pop #n #retval
         LDWA    -2,s    ; first recursive result
         STWA    retval,s ; store in retval

         LDWA    temp,s
         SUBA    2,i
         SUBSP   4,i    ; push #retval #n 
         STWA    0,s
         CALL    fib
         ADDSP   4,i    ; pop #n #retval
         LDWA    -2,s    ; second recursive result
         ADDA    retval,s
         STWA    retval,s ; store in retval

         BR      fibend

lesst0:  LDWA    0,i
         STWA    retval,s
         BR      fibend

lesst2:  LDWA    n,s    ; Load n
         STWA    retval,s ; For n=0 or n=1, return n
         BR      fibend

fibend:  ADDSP   2,i    ; pop #temp
         RET

; main program
main:    SUBSP   2,i    ; push #num 
         STRO    prompt,d
         DECI    num,s    ; read directly
         LDWA    num,s
         SUBSP   4,i    ; push #retval #n 
         STWA    0,s    ; put on stack
         CALL    fib    ; call fib function
         ADDSP   4,i    ; pop #n #retval

         DECO    -2,s    ; print result
         LDBA    '\n',i
         STBA    charOut,d ; print newline

         ADDSP   4,i    ; pop #n #retval
         STOP
        .END

