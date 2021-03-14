.data
     message1: .asciiz "Enter value of n (in base 10): "
     message2: .asciiz "Pairs of palindromic numbers from 1 through XX:"
     newLine: .asciiz "\n"
     found: .asciiz "FOUND"
.text
     main:
     
    la $a0, message1   # load the first welcome message into a0
    li $v0, 4           # load the print_string function into v0
    syscall             # tell the system to print the message
    
    li $v0, 5           # load the read_int function
    syscall             # make the syscall
    move $t0, $v0       # store the input in t0
    addi $t7, $zero, 0	# set t0 to 0
   	
      
    while: 
    			#Master loop encompassing isPalindrom function and print
    	bge $t7, $t0, endWhileLoop
    	
    	
    	#li $v0, 4
    	#la $a0, newLine
    	#syscall

    	li $t4, 10   			 # Base 10  
    	
    	jal isPalindrome
    	
    	move $t9, $t8

	li $t4, 2
	
    	jal isPalindrome
    	
    	bnez $t8, checkNum
	
	b continue
		
    	
    	checkNum:
    	
    		bnez $t9, printPalindrome

	continue:
		
	

    	addi $t7, $t7, 1  	

	b while
    
    endWhileLoop:
    	
    	li $v0, 10
        syscall	



	printPalindrome:
	
	        li $v0, 4
    	        la $a0, newLine
    	        syscall
    	
             	li $v0,1     #prepare system call 
                move $a0,$t7 #copy t0 to a0 
                syscall  
    	 
                b continue


    isPalindrome:
    
		move $t5, $t7       # forward = t5
    		#li $t2, 0           # reverse = 0	
    		addi $t2, $zero, 0  
		
   	 nestedWhile:
   	 	blez $t5, endNestedWhile
   	 	
   	 	mult $t2, $t4       # multiply reverse by base
                mflo $t6            # store result in t6
                move $t2, $t6       # copy the result to t2 variable 'reverse'

                div $t5, $t4        # divide temp by base
                mfhi $t6            # store remainder in t6
                mflo $t5            # temp = temp/base

                add $t2,$t2,$t6     # reverse = reverse + temp%base
                
                b nestedWhile
         jr $ra
   	 	
   	 	
   	 endNestedWhile:
   	 
   	    # check if palindrome and print message
            beq $t7, $t2, yespal # if t0 = t2, then num = reverse, yes palindrome
            bne $t7, $t2, notpal # if t0 != t2 then num != reverse, not palindrome
            jr $ra
           
   	     yespal:
   	    
   	    	addi $t8, $zero, 1 
   	        jr $ra
  
  
  	    notpal:
  	   	 addi $t8, $zero, 0
                 jr $ra