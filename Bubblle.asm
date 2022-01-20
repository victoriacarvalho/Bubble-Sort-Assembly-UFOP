.data
  	Mensagem: .asciiz "\n Bem vindo ao programa BUBBLE SORT \n Codigo feito por Victoria Carvalho \n"
  	Mensagem1: .asciiz "\n Digite o número do indice ["
  	Mensagem2: .asciiz "]: "
  	Mensagem3: .asciiz "\n ["
  	Mensagem4: .asciiz "\n Vetor lido: "
  	Mensagem5: .asciiz " \n "
  	Mensagem6: .asciiz "\n Vetor ordenado: "
  	ArrayDeDados: .word 0,0,0,0,0,0,0,0,0,0 #Inicializando o vetor com 0
  	n: .word 10	#Tamanho do array
  
.text 
	li $v0, 4			#Imprime a mensagem de boas vindas
	la $a0, Mensagem
	syscall
	
FuncaoPrincipal:
	
	addi $s1, $0, 10		#Inicializa $s1 com valor 10
	la $s2, ArrayDeDados		#Inicia o vetor Array no registrador $s
	addi $s4, $zero, 1		#Inicia j = 1 e percorre de 1 em 1
	addi $s3, $zero, 0		#Inicia i = 0
Loop1:
	addi $v0, $zero, 4		#Imprime a mensagem 1
	la $a0, Mensagem1
	syscall
	
	li $v0, 1			#Imprime o i
	add $a0, $t0, $s0		#Prepara para imprimir $t0
	syscall
	
	addi $v0, $zero, 4		#Imprime a mensagem 2
	la $a0, Mensagem2
	syscall
	
	add $t1, $t0, $t0 		#$t1 = i * 2
	add $t1, $t1, $t1		#$t1 = i * 4
	add $t1, $t1, $s2		#$t1 recebe o endereço base + i * 4
	lw $t2, 0($t1)			#$t0 salva posição [i]
	li $v0, 5			#Lê valores 
	syscall
	
	add $t2, $v0, $0		#salva $v0 em $t0
	sw $t2, 0($t1)			#$t0 
	addi $t0, $t0, 1		#$t0 = i++
	
	bne $t0, $s1, Loop1		#Enquanto $t0 != 10 faz o loop
	
	la $t2, ArrayDeDados		#Inicializa o vetor
	addi $t0, $zero, 0		#Inicializa i = 0
	
	addi $v0, $zero, 4		#Imprime a mensagem 4
	la $a0, Mensagem4
	syscall
	
Loop2:
	addi $v0, $zero, 4		#Imprime a mensagem 3
	la $a0, Mensagem3
	syscall
	
	li $v0, 1			#Carrega $t0 para imprimir
	add $a0, $t0, $s0
	syscall
	
	addi $v0, $zero, 4		#Imprime mensagem 2
	la $a0, Mensagem2
	syscall
	
	add $t1, $t0, $t0 		#$t1 = i * 2
	add $t1, $t1, $t1		#$t1 = i * 4
	add $t1, $t1, $s2		#$t1 recebe o endereço base + i * 4
	lw $t2, 0($t1)			#$t0 salva posição [i]
	li $v0, 1			#Imprime vetor
	add $a0, $t2, $s0			
	syscall
	
	addi $t0, $t0, 1		#Incrementa 1 em $t0
	
	bne $t0, $s1, Loop2		#Enquanto $t0 != $s1 faz o loop
	
	
	
	############################## Função BUBLLE SORT ##########################################################
	
	jal    BubblleSort		#Indo para função Bubble Sort
end:
	li $v0, 10			#Fim da execução da funcção Bubble
	syscall
	
BubblleSort:
	la $t1, ArrayDeDados		#Primeiro elemento do array
	lw $s0, n			#Tamanho do array = 10
	subu $s0, $s0, 1		# n--
	
	addu $s5, $zero, $zero		# troca = 0
	addu $s1, $zero, $zero		# i = 0
	
For:
	addu $s2, $zero, $zero		#j = 0
	
	subu $t9, $s0, $s1		#n - i - 1
		
	ForInterno:
		addu $t2, $t1, 4		#Próximo elemento da memoria
		lw $t4, ($t1)			#Array [i]
		lw $t5, ($t2)			#Array[j+i}
			
		bleu $t4, $t5, SemMudança	#Array [j} <= array[j+i] pule pra SemMudança
		
		sw $t4, ($t2)			#Array [j] = Array[j++]
		sw $t5, ($t1)			#Array[j++] = array[j]
		
		addu $s5, $zero, 1		#Mudar = 1
		
		SemMudança:
			beq $s2, $t9, FimForInterno	#j == n - i - 1 pular para Fim For Interno
			addu $s2, $s2, 1		#J++
			addu $t1, $t1, 4
			addu $t2, $t2, 4		#Proximo elemento
			b ForInterno			#J < n - i < 1 pular para For interno
			
	FimForInterno:
		beqz $s5, FimFor		#Se mudou, fim
		beq $s1, $s0, FimFor		#i = n--, FimFor
		addu $s1, $s1, 1		#i++
		la $t1, ArrayDeDados		#Próximo endereço de memória
		b For				#i < n - 1, va para for
		
FimFor:

	la $t1, ArrayDeDados		#Primeiro elemento no endereço de memória
	and $s1, $zero, $zero		# i = 0
	
	
	li $v0, 4			#Imprime a mensagem 5
	la $a0, Mensagem5
	syscall
	
	addi $v0, $zero, 4		#Imprime a mensagem 6
	la $a0, Mensagem6
	syscall
	
	li $v0, 4			#Imprime a mensagem 5
	la $a0, Mensagem5
	syscall
	
Print:
	lw $a0, ($t1)			#Array[i]
	addu $v0, $zero, 1
	syscall
	
	li $v0, 4			#Imprime a mensagem 5
	la $a0, Mensagem5
	syscall
	
	beq $s1, $s0, FimPrint		#i == n - 1, fim print
	addu $s1, $s1, 1		#i++
	addu $t1, $t1, 4		#Próximo elemento da memoria
	b Print
	
FimPrint:
		
			
	

	
    
