link del video yt:
https://youtu.be/V94VbBkZ-Ew


Joahan Torres Medrano

○ Descripción del proyecto.
En este proyecto se va crear un programa que debe generar una llave, el algoritmo tiene que generar la llave en base a
un nombre que le pediremos al usuario,despues este nombre lo va convertir a hexadecimal y esta sera la llave generada
despues la debe mostrar al usuario.


○ Instrucciones de compilación (comandos uasm64 y GoLink).
abri el cmd y cambie el directorio a la carpeta de la practica
lo ensamble con: uasm64 -win64 keygen_torres_joahan.asm
después lo enlanze con link.exe porque golink no me funciona en mi laptop. link.exe keygen_torres_joahan.obj kernel32.lib /subsystem:console /entry:main /out:keygen_torres_joahan.exe

○ Capturas de pantalla del programa en ejecución.

<img width="416" height="192" alt="image" src="https://github.com/user-attachments/assets/5725e47c-3911-4e48-bde2-b654cd261827" />

○ Explicación del algoritmo de generación de llave.

Primero se solicitan los handle para imprimir en consola y poder escribir en teclado.
Se mueve a RCX el handle de salida de la consola.
Se manda a RDX la dirección de memoria donde inicia el texto 'Ingresa tu nombre de usuario: '.
En R8 se mueve el tamaño del prompt y en R9 se le manda la dirección donde se almacena cuántos caracteres se escribieron.
Se llama WriteConsole para mostrar el texto en consola.

Se pausa el programa con ReadConsole para leer lo que escribió el usuario hasta que presione Enter, la cadena se guarda en el buffer.
Se valida que el usuario escribió algo con un cmp 2; si la cantidad de bytes escritos es menor o igual a 2, pasa con un jmp al mensaje de error.

Después se omiten los 2 bytes del salto de línea.
Se recorre carácter por carácter sumando su valor en ASCII en RAX y se guarda un acumulador en SUMA.

Se extraen los datos de 4 en 4 bits con una máscara AND.
Se convierten a su carácter ASCII correspondiente y se guardan de derecha a izquierda en hex_buffer.

Para imprimir la llave se hacen 3 llamadas a WriteConsole:

Una imprime 'Tu llave es: '

Otra el hex_buffer

Y la última un salto de línea

Después de imprimir se utiliza un jmp al final del programa y finaliza
