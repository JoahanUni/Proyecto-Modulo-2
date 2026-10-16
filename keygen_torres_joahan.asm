; ------------------------------------------------------------
; Proyecto Módulo 2 - Keygen Básico
; Fase 1: Captura del nombre y cálculo de la suma ASCII
; ------------------------------------------------------------
extrn GetStdHandle: proc
extrn WriteConsoleA: proc
extrn ReadConsoleA: proc
extrn ExitProcess: proc
.data
prompt db 'Ingresa tu nombre de usuario: ', 0
prompt_len dq $ - prompt - 1
buffer db 64 DUP (0)
buffer_len dq 64
leidos dq 0
escritos dq 0
mensaje_llave db 'Tu llave es: ', 0
mensaje_len dq $ - mensaje_llave - 1
newline db 13, 10, 0
newline_len dq $ - newline - 1
error_vacio db 'Error: nombre no valido.', 13, 10, 0
error_len dq $ - error_vacio - 1
suma dq 0
hex_buffer db 17 DUP (0) ; 16 dígitos + null
.code
main proc
sub rsp, 28h
; ------------------------------------------------------------
; 1. Obtener handles de consola
; ------------------------------------------------------------
mov rcx, -11
call GetStdHandle
mov rbx, rax ; stdout
mov rcx, -10
call GetStdHandle
mov rsi, rax ; stdin
; ------------------------------------------------------------
; 2. Mostrar prompt
; ------------------------------------------------------------
mov rcx, rbx
lea rdx, prompt
mov r8, [prompt_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA
; ------------------------------------------------------------
; 3. Leer nombre del usuario
; ------------------------------------------------------------
mov rcx, rsi
lea rdx, buffer
mov r8, [buffer_len]
lea r9, leidos
mov qword ptr [rsp + 20h], 0
call ReadConsoleA
; ------------------------------------------------------------
; 4. Verificar si el nombre está vacío (solo Enter)
; ------------------------------------------------------------
mov rax, [leidos]
    cmp rax, 2
    jle error_nombre_vacio
    mov al, byte ptr [buffer]
    cmp al, 13                  ; ¿Es '\r' (Carriage Return)?
    je error_nombre_vacio
    cmp al, 10                  ; ¿Es '\n' (Line Feed)?
    je error_nombre_vacio
; ------------------------------------------------------------
; 5. TODO: Calcular la suma de los valores ASCII
; ------------------------------------------------------------
    lea rsi, buffer
    mov rcx, [leidos]
    sub rcx, 2                  ; Ignorar el salto de línea (\r\n)
    xor rax, rax

suma_loop:
    movzx rdx, byte ptr [rsi]
    add rax, rdx                ; Sumar ASCII del carácter
    inc rsi
    loop suma_loop

    mov [suma], rax            
; ------------------------------------------------------------
; 6. TODO: Convertir la suma a hexadecimal
; ------------------------------------------------------------
    mov rax, [suma]           
    lea rdi, hex_buffer         ; RDI apunta al inicio del buffer de texto
    add rdi, 15                 ; Mover RDI a la posición 15 (escribir de derecha a izquierda)

    mov rcx, 16                 ; Contador
convertir_hex_loop:
    mov rdx, rax                
    and rdx, 0Fh                ; Aislar los últimos 4 bits

    cmp dl, 9                   ; ¿El valor es un dígito entre 0 y 9?
    jbe es_digito               ; Si es <= 9, saltar a la conversión de número
    add dl, 'A' - 10            ; Si es > 9, ajustar para obtener letras 'A'-'F'
    jmp guardar_nibble

es_digito:
    add dl, '0'                 ; Ajustar para obtener caracteres '0'-'9'

guardar_nibble:
    mov byte ptr [rdi], dl      ; Guardar el carácter ASCII en el buffer
    dec rdi                     ; Mover el puntero una casilla a la izquierda
    shr rax, 4                  ; Desplazar 4 bits a la derecha 
    loop convertir_hex_loop     ; Decrementar RCX y repetir mientras RCX > 0

; ------------------------------------------------------------
; 7. TODO: Mostrar la llave en pantalla
; ------------------------------------------------------------
    ; 7.1 Imprimir etiqueta "Tu llave es: "
    mov rcx, rbx
    lea rdx, mensaje_llave
    mov r8, [mensaje_len]
    lea r9, escritos
    mov qword ptr [rsp + 20h], 0
    call WriteConsoleA

    ; 7.2 Imprimir la llave de 16 dígitos en hex
    mov rcx, rbx
    lea rdx, hex_buffer
    mov r8, 16
    lea r9, escritos
    mov qword ptr [rsp + 20h], 0
    call WriteConsoleA

    ; 7.3 Imprimir salto de línea final (\r\n)
    mov rcx, rbx
    lea rdx, newline
    mov r8, [newline_len]
    lea r9, escritos
    mov qword ptr [rsp + 20h], 0
    call WriteConsoleA
    
jmp fin
; ------------------------------------------------------------
; 8. Manejo de error: nombre vacío
; ------------------------------------------------------------
error_nombre_vacio:
mov rcx, rbx
lea rdx, error_vacio
mov r8, [error_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA
; ------------------------------------------------------------
; 9. Terminar
; ------------------------------------------------------------
fin:
xor ecx, ecx
call ExitProcess
main endp
end