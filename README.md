link del video yt:
https://youtu.be/V94VbBkZ-Ew


Joahan Torres Medrano

○ Descripción del proyecto.
En este proyecto se va crear un programa que debe generar una llave, el algoritmo tiene que generar la llave en base a
un nombre que le pediremos al usuario,despues este nombre lo va convertir a hexadecimal y esta sera la llave generada
despues la debe mostrar al usuario.


○ Instrucciones de compilación (comandos uasm64 y GoLink).
abri el cmd y cambie el directorio a la carpeta de la practica
lo ensamle con uasm64 -win64 keygen_torres_joahan.asm
despues lo enlanze con link.exe keygen_torres_joahan.obj kernel32.lib /subsystem:console /entry:main /out:keygen_torres_joahan.exe

○ Capturas de pantalla del programa en ejecución.

<img width="416" height="192" alt="image" src="https://github.com/user-attachments/assets/5725e47c-3911-4e48-bde2-b654cd261827" />

○ Explicación del algoritmo de generación de llave.

Primero se solicitan los los handle para imprimir en consola y poder escribir en teclado
se mueve a RCX el handle de salida de la consola
se manda a RDX la dirección de memoria donde inicia el texto 'Ingresa tu nombre de usuario: '.
en r8 se mueve el tamaño del prompt y en r9 se le manda la direccion donde se almacena cuantos caracteres se escribieron
se llama write console para mostrar el texto en consola

Se pausa el programa con readconsole para leer lo que escribio el usuario hasta que presione enter,
la cadena se guarda en el buffer
se valida que el usuario escribio algo con un cmp 2,si la cantidad de bytes escritos
es menor o igual a 2 pasa al mensaje de error
despues se omiten los 2 bytes del salto de linea
se recorre caracter por caracter sumando su valor en ASCII en RAX y se guarda un acumulador en SUMA

se extraen los datos de 4 en 4 bits con una mascara AND
se convierten a su caracter ASCII correspondiente y se guardan de derecha a izquierda en hex_buffer

para imprimir la llave se hacen 3 llamadas a write console
una imprime 'Tu llave es: '
otra el hex_buffer
y la ultima un salto de linea

despues se ejecuta un jmp hacia la seccion de errores y cierre del programa
en caso de no escribir nada al pedir el nombre al usuario aqui te manda y termina el programa
y al mostrar la clave tambien el jmp te manda al exitprocess
