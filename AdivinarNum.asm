#ProyectoP1 Organizacion de Computadores Irving Macias Nick Arevalo
#Pedirle a usuario un numero
#validacionFRio frio como el agua del rio
#validacion Frio 
#Validacion Caliente
#Validacion Caliente caliente
#Validacion sigue intentando
.data
	mensaje1: .asciiz "-----------Bienvenido al juego de adivinar el número-----------\n Tienes 3 intentos para adivinar un numero entre 1 y 200\n"
	mensaje2: .asciiz "Ingrese un numero entre (1-200)\n:"
	texto_felicitaciones: .asciiz "Felicitaciones! Adivinaste el numero en %d intentos\n"
	texto_frio_frio:   .asciiz "Frio frio.\n"
	texto_frio: .asciiz "Frio.\n"
	texto_caliente: .asciiz "Caliente.\n"
	texto_caliente_caliente:  .asciiz "Caliente caliente.\n"
	sigue_intentando: .asciiz "Sigue intentando:\n"
	validacion: .asciiz "Por favor ingresa solo numeros validos c:\n"
	noAdivinaste: .asciiz "Lo siento, no adivinaste el numero :c"
	correcto: .asciiz "El numero correcto era:"
	terminado: .asciiz "Juego terminado."
    	
.text
	main:
	#Generar Numero random del 1,200(Demore 3h en esto)
	li $v0, 42  # 42 el systemcall para generar el numero random
	li $a1, 200 # $a1 donde esta el tope
	syscall     # El numero random estara en $a0
	add $a0, $a0, 1  #Se le suma uno para que sea el mas bajo
	move $t1,$a0 #Guardo el numero en t1 para que no se pierda
	
	#Contador
	li $t3, 0 #guardamos la variable 0 en t3
	
	#ImepresionDeBienvenido
	li $v0, 4
	la $a0, mensaje1
	syscall 
	
	fin:
	#Impresion de Insertar digito
	li	$v0, 4
	la	$a0, mensaje2
	syscall
	
	#leer primer digito
	li $v0, 5
	syscall 
	move $t0,$v0 #se guardo el primer numero en $t0
	
	#Verificar si ya pase los 3 intentos
	beq $t3,2,exitLose #Nose porque pero lo intenta 4 veces cuando pones 3
	addi $t3,$t3,1 #Aumentar los intentos
	beq $t0,$t1,exitWin #Si son iguales gana

    	# elif numero_ingresado - 20 <= numero_objetivo <= numero_ingresado - 10
    	#ble <= yyyyyy  bge >=
   	sub $t2, $t0, 20
    	ble $t2, $t1, frio_frio
    	sub $t2, $t0, 10
    	ble $t2, $t1, frio_frio

    	# elif numero_ingresado - 9 <= numero_objetivo <= numero_ingresado - 1
    	sub $t2, $t0, 9
    	ble $t2, $t1, frio
    	sub $t2, $t0, 1
    	ble $t2, $t1, frio

    	# elif numero_ingresado + 10 <= numero_objetivo <= numero_ingresado + 20
    	addi $t2, $t0, 10
    	ble $t2, $t1, caliente
    	addi $t2, $t0, 20
    	ble $t2, $t1, caliente

    	# elif numero_ingresado + 1 <= numero_objetivo <= numero_ingresado + 9
    	addi $t2, $t0, 1
    	ble $t2, $t1, caliente_caliente
    	addi $t2, $t0, 9
    	ble $t2, $t1, caliente_caliente

    	# else (mensaje por defecto)
    	li $v0, 4
    	la $a0, sigue_intentando
    	syscall
    	j fin
frio_frio:
	li	$v0, 4
	la	$a0, texto_frio_frio
	syscall
	li	$v0, 4
	la	$a0, sigue_intentando
	syscall
	j fin
frio:
	li	$v0, 4
	la	$a0, texto_frio
	syscall
	li	$v0, 4
	la	$a0, sigue_intentando
	syscall
	j fin
caliente:
	li	$v0, 4
	la	$a0, texto_caliente
	syscall
	li	$v0, 4
	la	$a0, sigue_intentando
	syscall
	j fin
caliente_caliente:
	li	$v0, 4
	la	$a0, texto_caliente_caliente
	syscall
	li	$v0, 4
	la	$a0, sigue_intentando
	syscall
	j fin
exitLose:
	li $v0, 4
	la $a0, noAdivinaste
	syscall 
	li $v0, 10
    	syscall
exitWin:
	li $v0, 4
	la $a0, texto_felicitaciones
	syscall 
	#Debo imprimir cuantos fallos hubo en t3 creo
	li $v0, 4
	la $a0, correcto
	syscall
	li $v0, 10
    	syscall