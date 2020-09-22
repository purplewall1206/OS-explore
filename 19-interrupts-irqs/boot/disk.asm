; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha
; PUSHA
; 压入 AX、CX、DX、BX、原始 SP、BP、SI 及 DI
; PUSHAD
; 压入 EAX、ECX、EDX、EBX、原始 ESP、EBP、ESI 及 EDI

    ; reading from disk requires setting specific values in all registers
    ; so we will overwrite our input parameters from 'dx'. Let's save it
    ; to the stack for later use.
    push dx

    mov ah, 0x02 ; ah <- int 0x13 function. 0x02 = 'read'
    mov al, dh   ; al <- number of sectors to read (0x01 .. 0x80)
    mov cl, 0x02 ; cl <- sector (0x01 .. 0x11)
                 ; 0x01 is our boot sector, 0x02 is the first 'available' sector
    mov ch, 0x00 ; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
    ; dl <- drive number. Our caller sets it as a parameter and gets it from BIOS
    ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00 ; dh <- head number (0x0 .. 0xF)

    ; [es:bx] <- pointer to buffer where the data will be stored
    ; caller sets it up for us, and it is actually the standard location for int 13h
    int 0x13      ; BIOS interrupt
    jc disk_error ; if error (stored in the carry bit)

    pop dx
    cmp al, dh    ; BIOS also sets 'al' to the # of sectors read. Compare it.
    jne sectors_error
    popa
    ret

disk_error:
    ; mov bx, DISK_ERROR
    ; call print
    ; call print_nl
    mov dh, ah ; ah = error code, dl = disk drive that dropped the error
    ; call print_hex ; check out the code at http://stanislavs.org/helppc/int_13-1.html
    jmp disk_loop

sectors_error:
    ; mov bx, SECTORS_ERROR
    ; call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error",0
SECTORS_ERROR: db "Incorrect number of sectors read", 0

    ; AH = 02
	; AL = number of sectors to read	(1-128 dec.)
	; CH = track/cylinder number  (0-1023 dec., see below)
	; CL = sector number  (1-17 dec.)
	; DH = head number  (0-15 dec.)
	; DL = drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)
	; ES:BX = pointer to buffer


	; on return:
	; AH = status  (see INT 13,STATUS)
	; AL = number of sectors read
	; CF = 0 if successful
	;    = 1 if error


	; - BIOS disk reads should be retried at least three times and the
	;   controller should be reset upon error detection
	; - be sure ES:BX does not cross a 64K segment boundary or a
	;   DMA boundary error will occur
	; - many programming references list only floppy disk register values
	; - only the disk number is checked for validity
	; - the parameters in CX change depending on the number of cylinders;
	;   the track/cylinder number is a 10 bit value taken from the 2 high
	;   order bits of CL and the 8 bits in CH (low order 8 bits of track):

	;   |F|E|D|C|B|A|9|8|7|6|5-0|  CX
	;    | | | | | | | | | |	`-----	sector number
	;    | | | | | | | | `---------  high order 2 bits of track/cylinder
	;    `------------------------  low order 8 bits of track/cyl number
