PA equ 30h
PB equ 31h
CA equ 32h
CB equ 33h
org 1000h
msj_fin db "Fin de programa"
msj_c db "Arquitectura de Computadoras: ACTIVADA", 10
ptr_fin db ?
org 3000h
config:
    push ax
    mov al, 0FFh
    out CA, al
    mov al, 0
    out CB, al
    pop ax
    ret
sub_a:
    ; devuelve 1 en ah si se debe finalizar o 0 caso contrario
    ; recibe en al el estado de las llaves
    cmp al, 0
    jnz else_a
        mov ah, 1
        ret
    else_a:
        mov ah, 0
    ret
sub_b: 
    ; recibe en al el estado de las llaves
    push ax
    not al
    out PB, al
    pop ax
    ret
sub_c:
    ; recibe en al el estado de las llaves
    push ax
    push bx
    and al, 01h
    jz fin_c
        mov al, offset ptr_fin - offset msj_c
        mov bx, offset msj_c
        int 7
    fin_c:    
        pop ax
        pop bx
        ret
org 2000h
call config
bucle:
    in al, PA
    call sub_a
    cmp ah, 1
    jz fin
    call sub_b
    call sub_c    
    jmp bucle
fin:
    mov bx, offset msj_fin
    mov al, offset msj_c - offset msj_fin
    int 0
    end