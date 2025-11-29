INCLUDE c:\Users\Abdullah\.vscode\extensions\istareatscreens.masm-runner-0.9.1\native\irvine\Irvine32.inc

.data
    ; =============================================================
    ; UI STRINGS AND DESIGN ELEMENTS
    ; =============================================================
    appTitle      BYTE "================================================",0Dh,0Ah
                  BYTE "          AES-128 ENCRYPTION SYSTEM             ",0Dh,0Ah
                  BYTE "================================================",0

    secInput      BYTE 0Dh,0Ah,"              [ INPUT SECTION ]",0Dh,0Ah,"------------------------------------------------",0Dh,0Ah,0
    secOutput     BYTE 0Dh,0Ah,"              [ RESULT SECTION ]",0Dh,0Ah,"------------------------------------------------",0Dh,0Ah,0
    
    promptKey     BYTE "  > Enter 16-char Key      : ",0
    promptPlain   BYTE "  > Enter 16-char Plaintext: ",0
    
    msgProcess    BYTE 0Dh,0Ah,"  [...] Processing Encryption and Decryption...",0Dh,0Ah,0

    lblOriginal   BYTE "  [ORIGINAL]  : ",0
    lblEncrypt    BYTE "  [ENCRYPTED] : ",0
    lblDecrypt    BYTE "  [DECRYPTED] : ",0

    ; =============================================================
    ; AES DATA (S-Box, Rcon, State)
    ; =============================================================
    Sbox BYTE 063h,07Ch,077h,07Bh,0F2h,06Bh,06Fh,0C5h,030h,001h,067h,02Bh,0FEh,0D7h,0ABh,076h
        BYTE 0CAh,082h,0C9h,07Dh,0FAh,059h,047h,0F0h,0ADh,0D4h,0A2h,0AFh,09Ch,0A4h,072h,0C0h
        BYTE 0B7h,0FDh,093h,026h,036h,03Fh,0F7h,0CCh,034h,0A5h,0E5h,0F1h,071h,0D8h,031h,015h
        BYTE 004h,0C7h,023h,0C3h,018h,096h,005h,09Ah,007h,012h,080h,0E2h,0EBh,027h,0B2h,075h
        BYTE 009h,083h,02Ch,01Ah,01Bh,06Eh,05Ah,0A0h,052h,03Bh,0D6h,0B3h,029h,0E3h,02Fh,084h
        BYTE 053h,0D1h,000h,0EDh,020h,0FCh,0B1h,05Bh,06Ah,0CBh,0BEh,039h,04Ah,04Ch,058h,0CFh
        BYTE 0D0h,0EFh,0AAh,0FBh,043h,04Dh,033h,085h,045h,0F9h,002h,07Fh,050h,03Ch,09Fh,0A8h
        BYTE 051h,0A3h,040h,08Fh,092h,09Dh,038h,0F5h,0BCh,0B6h,0DAh,021h,010h,0FFh,0F3h,0D2h
        BYTE 0CDh,00Ch,013h,0ECh,05Fh,097h,044h,017h,0C4h,0A7h,07Eh,03Dh,064h,05Dh,019h,073h
        BYTE 060h,081h,04Fh,0DCh,022h,02Ah,090h,088h,046h,0EEh,0B8h,014h,0DEh,05Eh,00Bh,0DBh
        BYTE 0E0h,032h,03Ah,00Ah,049h,006h,024h,05Ch,0C2h,0D3h,0ACh,062h,091h,095h,0E4h,079h
        BYTE 0E7h,0C8h,037h,06Dh,08Dh,0D5h,04Eh,0A9h,06Ch,056h,0F4h,0EAh,065h,07Ah,0AEh,008h
        BYTE 0BAh,078h,025h,02Eh,01Ch,0A6h,0B4h,0C6h,0E8h,0DDh,074h,01Fh,04Bh,0BDh,08Bh,08Ah
        BYTE 070h,03Eh,0B5h,066h,048h,003h,0F6h,00Eh,061h,035h,057h,0B9h,086h,0C1h,01Dh,09Eh
        BYTE 0E1h,0F8h,098h,011h,069h,0D9h,08Eh,094h,09Bh,01Eh,087h,0E9h,0CEh,055h,028h,0DFh
        BYTE 08Ch,0A1h,089h,00Dh,0BFh,0E6h,042h,068h,041h,099h,02Dh,00Fh,0B0h,054h,0BBh,016h

    SboxInv BYTE 052h,009h,06Ah,0D5h,030h,036h,0A5h,038h,0BFh,040h,0A3h,09Eh,081h,0F3h,0D7h,0FBh
            BYTE 07Ch,0E3h,039h,082h,09Bh,02Fh,0FFh,087h,034h,08Eh,043h,044h,0C4h,0DEh,0E9h,0CBh
            BYTE 054h,07Bh,094h,032h,0A6h,0C2h,023h,03Dh,0EEh,04Ch,095h,00Bh,042h,0FAh,0C3h,04Eh
            BYTE 008h,02Eh,0A1h,066h,028h,0D9h,024h,0B2h,076h,05Bh,0A2h,049h,06Dh,08Bh,0D1h,025h
            BYTE 072h,0F8h,0F6h,064h,086h,068h,098h,016h,0D4h,0A4h,05Ch,0CCh,05Dh,065h,0B6h,092h
            BYTE 06Ch,070h,048h,050h,0FDh,0EDh,0B9h,0DAh,05Eh,015h,046h,057h,0A7h,08Dh,09Dh,084h
            BYTE 090h,0D8h,0ABh,000h,08Ch,0BCh,0D3h,00Ah,0F7h,0E4h,058h,005h,0B8h,0B3h,045h,006h
            BYTE 0D0h,02Ch,01Eh,08Fh,0CAh,03Fh,00Fh,002h,0C1h,0AFh,0BDh,003h,001h,013h,08Ah,06Bh
            BYTE 03Ah,091h,011h,041h,04Fh,067h,0DCh,0EAh,097h,0F2h,0CFh,0CEh,0F0h,0B4h,0E6h,073h
            BYTE 096h,0ACh,074h,022h,0E7h,0ADh,035h,085h,0E2h,0F9h,037h,0E8h,01Ch,075h,0DFh,06Eh
            BYTE 047h,0F1h,01Ah,071h,01Dh,029h,0C5h,089h,06Fh,0B7h,062h,00Eh,0AAh,018h,0BEh,01Bh
            BYTE 0FCh,056h,03Eh,04Bh,0C6h,0D2h,079h,020h,09Ah,0DBh,0C0h,0FEh,078h,0CDh,05Ah,0F4h
            BYTE 01Fh,0DDh,0A8h,033h,088h,007h,0C7h,031h,0B1h,012h,010h,059h,027h,080h,0ECh,05Fh
            BYTE 060h,051h,07Fh,0A9h,019h,0B5h,04Ah,00Dh,02Dh,0E5h,07Ah,09Fh,093h,0C9h,09Ch,0EFh
            BYTE 0A0h,0E0h,03Bh,04Dh,0AEh,02Ah,0F5h,0B0h,0C8h,0EBh,0BBh,03Ch,083h,053h,099h,061h
            BYTE 017h,02Bh,004h,07Eh,0BAh,077h,0D6h,026h,0E1h,069h,014h,063h,055h,021h,00Ch,07Dh

    Rcon DWORD 01000000h,02000000h,04000000h,08000000h,10000000h

    keyStr BYTE 17 DUP(0)
    keyBytes BYTE 16 DUP(0)
    roundKeys DWORD 44 DUP(0)

    plainStr BYTE 17 DUP(0)
    plainBytes BYTE 16 DUP(0)
    state BYTE 16 DUP(0)
    tempState BYTE 16 DUP(0)

.data?
    curIndex DWORD ?

.code

main PROC
    call Clrscr

    ; ----------------------------
    ; PRINT HEADER (Cyan on Black)
    ; ----------------------------
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    lea edx, appTitle
    call WriteString

    ; ----------------------------
    ; INPUT SECTION
    ; ----------------------------
    mov eax, white + (black * 16)
    call SetTextColor
    lea edx, secInput
    call WriteString

    ; Input Key
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    lea edx, promptKey
    call WriteString
    
    mov eax, white + (black * 16)
    call SetTextColor
    lea edx, keyStr
    mov ecx, 17
    call ReadString

    ; Input Plaintext
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    lea edx, promptPlain
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    lea edx, plainStr
    mov ecx, 17
    call ReadString

    ; ----------------------------
    ; PROCESS DATA
    ; ----------------------------
    ; Convert Key
    lea esi, keyStr
    lea edi, keyBytes
    mov ecx, 16
copy_key_loop:
    mov al,[esi]
    mov [edi],al
    inc esi
    inc edi
    loop copy_key_loop

    ; Initialize w[0..3]
    lea esi,keyBytes
    lea edi,roundKeys
    mov ecx,4
init_w0:
    mov al,[esi+3]
    mov ah,[esi+2]
    mov dl,[esi+1]
    mov dh,[esi]
    movzx eax,ax
    shl edx,16
    or eax,edx
    mov [edi],eax
    add esi,4
    add edi,4
    loop init_w0

    call KeyExpansion

    ; Convert Plaintext
    lea esi,plainStr
    lea edi,plainBytes
    mov ecx,16
copy_plain_loop:
    mov al,[esi]
    mov [edi],al
    inc esi
    inc edi
    loop copy_plain_loop

    lea esi,plainBytes
    lea edi,state
    mov ecx,16
    rep movsb

    ; Show Processing Message (Yellow)
    mov eax, yellow + (black * 16)
    call SetTextColor
    lea edx, msgProcess
    call WriteString

    ; ----------------------------
    ; RESULT SECTION
    ; ----------------------------
    mov eax, white + (black * 16)
    call SetTextColor
    lea edx, secOutput
    call WriteString

    ; 1. Original (Light Gray)
    mov eax, lightGray + (black * 16)
    call SetTextColor
    lea edx, lblOriginal
    call WriteString
    mov eax, white + (black * 16) ; Text in White
    call SetTextColor
    call PrintState

    ; 2. Encrypt
    call Encrypt5

    ; Print Encrypted (Light Red for "Locked")
    mov eax, lightRed + (black * 16)
    call SetTextColor
    lea edx, lblEncrypt
    call WriteString
    mov eax, lightRed + (black * 16) ; Keep Encrypted text Red
    call SetTextColor
    call PrintState

    ; 3. Decrypt
    call Decrypt5

    ; Print Decrypted (Light Green for "Success")
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    lea edx, lblDecrypt
    call WriteString
    mov eax, white + (black * 16) ; Text in White
    call SetTextColor
    call PrintState

    ; Reset Color and Exit
    mov eax, white + (black * 16)
    call SetTextColor
    call Crlf

    call ReadChar
    
    INVOKE ExitProcess,0
main ENDP

; ==========================================================
; LOGIC PROCEDURES (AES Core)
; ==========================================================

KeyExpansion PROC
    lea esi, roundKeys
    add esi,16
    mov ebx,4
keyexp_loop:
    mov eax,[esi-4]
    mov edx,[esi-16]
    mov curIndex,ebx
    test ebx,3
    jne not_mult4
    call g
    xor eax,edx
    jmp store
not_mult4:
    xor eax,edx
store:
    mov [esi],eax
    add esi,4
    inc ebx
    cmp ebx,20
    jl keyexp_loop
    ret
KeyExpansion ENDP

g PROC Uses edx
    call RotWord
    call SubWord
    mov ecx,curIndex
    shr ecx,2
    dec ecx
    mov edx,Rcon[ecx*4]
    xor eax,edx
    ret
g ENDP

RotWord PROC
    rol eax,8
    ret
RotWord ENDP

SubWord PROC Uses ebx
    push edi
    xor ebx,ebx
    mov edi,3
sub_loop:
    mov edx,eax
    mov ecx,edi
    shl ecx,3
    shr edx,cl
    and edx,0FFh
    mov dl,[Sbox+edx]
    shl ebx,8
    or ebx,edx
    dec edi
    cmp edi,-1
    jne sub_loop
    mov eax,ebx
    pop edi
    ret
SubWord ENDP

Encrypt5 PROC Uses esi edi ecx ebx
    mov ecx,0
    call AddRoundKey
    mov ecx,1
enc_loop:
    call SubBytes_State
    call ShiftRows_State
    call AddRoundKey
    inc ecx
    cmp ecx,4
    jl enc_loop
    mov ecx,4
    call SubBytes_State
    call ShiftRows_State
    call AddRoundKey
    ret
Encrypt5 ENDP

SubBytes_State PROC Uses esi ecx
    lea esi,state
    mov ecx,16
sbox_loop:
    mov al,[esi]
    movzx eax,al
    mov al,[Sbox+eax]
    mov [esi],al
    inc esi
    loop sbox_loop
    ret
SubBytes_State ENDP

ShiftRows_State PROC Uses esi edi ecx
    lea esi,state
    lea edi,tempState
    ; Row 0
    mov al,[esi+0]
    mov [edi+0],al
    mov al,[esi+1]
    mov [edi+1],al
    mov al,[esi+2]
    mov [edi+2],al
    mov al,[esi+3]
    mov [edi+3],al
    ; Row 1
    mov al,[esi+5]
    mov [edi+4],al
    mov al,[esi+6]
    mov [edi+5],al
    mov al,[esi+7]
    mov [edi+6],al
    mov al,[esi+4]
    mov [edi+7],al
    ; Row 2
    mov al,[esi+10]
    mov [edi+8],al
    mov al,[esi+11]
    mov [edi+9],al
    mov al,[esi+8]
    mov [edi+10],al
    mov al,[esi+9]
    mov [edi+11],al
    ; Row 3
    mov al,[esi+15]
    mov [edi+12],al
    mov al,[esi+12]
    mov [edi+13],al
    mov al,[esi+13]
    mov [edi+14],al
    mov al,[esi+14]
    mov [edi+15],al
    lea esi,tempState
    lea edi,state
    mov ecx,16
    rep movsb
    ret
ShiftRows_State ENDP

AddRoundKey PROC Uses esi edi ebx ecx
    mov ebx,ecx
    imul ebx,16
    lea esi,roundKeys
    add esi,ebx
    lea edi,state
    mov ecx,16
ark_loop:
    mov al,[edi]
    mov dl,[esi]
    xor al,dl
    mov [edi],al
    inc esi
    inc edi
    loop ark_loop
    ret
AddRoundKey ENDP

PrintState PROC Uses esi ecx eax edx
    lea esi,state
    mov ecx,16
print_ascii:
    mov al,[esi]
    cmp al,20h
    jb not_printable
    cmp al,7Eh
    ja not_printable
    call WriteChar
    jmp next_char
not_printable:
    mov al,'.'
    call WriteChar
next_char:
    inc esi
    loop print_ascii
    call Crlf
    ret
PrintState ENDP

Decrypt5 PROC
    mov ecx,4
    call AddRoundKey
    call InvShiftRows_State
    call InvSubBytes_State
    mov ecx,3
dec_loop:
    call AddRoundKey
    call InvShiftRows_State
    call InvSubBytes_State
    dec ecx
    jnz dec_loop
    mov ecx,0
    call AddRoundKey
    ret
Decrypt5 ENDP

InvSubBytes_State PROC Uses esi ecx
    lea esi,state
    mov ecx,16
inv_loop:
    mov al,[esi]
    movzx eax,al
    mov al,[SboxInv+eax]
    mov [esi],al
    inc esi
    loop inv_loop
    ret
InvSubBytes_State ENDP

InvShiftRows_State PROC Uses esi edi ecx
    lea esi,state
    lea edi,tempState
    ; Row 0
    mov al,[esi+0]
    mov [edi+0],al
    mov al,[esi+1]
    mov [edi+1],al
    mov al,[esi+2]
    mov [edi+2],al
    mov al,[esi+3]
    mov [edi+3],al
    ; Row 1
    mov al,[esi+7]
    mov [edi+4],al
    mov al,[esi+4]
    mov [edi+5],al
    mov al,[esi+5]
    mov [edi+6],al
    mov al,[esi+6]
    mov [edi+7],al
    ; Row 2
    mov al,[esi+10]
    mov [edi+8],al
    mov al,[esi+11]
    mov [edi+9],al
    mov al,[esi+8]
    mov [edi+10],al
    mov al,[esi+9]
    mov [edi+11],al
    ; Row 3
    mov al,[esi+13]
    mov [edi+12],al
    mov al,[esi+14]
    mov [edi+13],al
    mov al,[esi+15]
    mov [edi+14],al
    mov al,[esi+12]
    mov [edi+15],al
    lea esi,tempState
    lea edi,state
    mov ecx,16
    rep movsb
    ret
InvShiftRows_State ENDP

END main