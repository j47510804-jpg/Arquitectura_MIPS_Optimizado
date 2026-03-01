# Laboratorio: Estructura de Computadores
# Actividad: Optimizaci�n de Pipeline en Procesadores MIPS
# Objetivo: Calcular Y[i] = A * X[i] + B e identificar riesgos de datos.

.data
    vector_x: .word 1, 2, 3, 4, 5, 6, 7, 8
    vector_y: .space 32          # Espacio para 8 enteros (8 * 4 bytes)
    const_a:  .word 3
    const_b:  .word 5
    tamano:   .word 8

.text
.globl main

main:
    # --- Inicialización ---
    la $s0, vector_x      # Dirección base de X
    la $s1, vector_y      # Dirección base de Y
    lw $t0, const_a       # Cargar constante A
    lw $t1, const_b       # Cargar constante B
    lw $t2, tamano        # Cargar el tamaño del vector
    li $t3, 0             # �?ndice i = 0

loop:
    beq $t3, $t2, fin
    
    lw  $t6, 0($s0)    # Carga directa usando el puntero actual
    addi $t3, $t3, 1   # Incrementamos el contador aquí (independiente)
    
    mul $t7, $t6, $t0  # $t6 ya está listo
    addu $t8, $t7, $t1
    
    sw  $t8, 0($s1)    # Guarda el resultado
    
    addi $s0, $s0, 4   # Avanzamos el puntero de X
    addi $s1, $s1, 4   # Avanzamos el puntero de Y
    j loop
    
fin:
    # --- Finalización del programa ---
    li $v0, 10            # Syscall para terminar ejecución
    syscall
