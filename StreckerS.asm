.data
     message1: .asciiz "Enter value of n (in base 10): "
     message2: .asciiz "Pairs of palindromic numbers from 1 through "
     message3: .asciiz ":" 
     newLine: .asciiz "\n"
     newTab: .asciiz "\t"
.text
     main:
     
    la $a0, message1    
    li $v0, 4           
    syscall             # tell the system to print the message
    
    li $v0, 5           
    syscall             
    move $t0, $v0       # store the input in t0
    li $t7, 1
    
    la $a0, message2    #statement for user
    li $v0, 4           
    syscall 
    
    li $v0,1            #print value user entered
    move $a0,$t0
    syscall
     
    la $a0, message3    #format printed statement with colon
    li $v0, 4           
    syscall 
    
    la $a0, newLine    #statement for user
    li $v0, 4           
    syscall 
    
    
      
    while: 
    			#Master loop encompassing isPalindrom function and print
    	bge $t7, $t0, endWhileLoop

    	li $t4, 10   	          #Base 10  
    	
    	jal isPalindrome
    	
    	move $t9, $t8

	li $t4, 2                 #Base 2
	
    	jal isPalindrome
    	
    	bnez $t8, checkNum        #Check if 8 is 1 or True
	
	b continue
		
    	
    	checkNum:
    	
    		bnez $t9, printPalindrome     #Check if t9 is 1 or True

	continue:		

    	addi $t7, $t7, 1  	 #loop counter

	b while
    
    endWhileLoop:
    	
    	li $v0, 10
        syscall	

	printPalindrome:	
		li $t3, 1
		
		move $t5, $t7
		and $s1, $t5, $t3
		
		li $v0, 4
    	        la $a0, newLine
    	        syscall
    	        
    	        li $v0,1     #prepare system call 
                move $a0, $t7 #copy t0 to a0 
                syscall  
                
                li $v0, 4
    	        la $a0, newTab
    	        syscall
    	        
    	        	
		li $v0, 1
    	        move $a0, $s1
    	        syscall
		
			binaryLoop:
			
				srl $t5, $t5, 1    #recursively prints out each digit of the binary number
				beqz $t5 binaryEnd
				and $s1, $t5, $t3
				
				li $v0, 1
    	                        move $a0, $s1
    	                        syscall
    	                        	
				b binaryLoop
	
			binaryEnd:

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
            beq $t7, $t2, yespal # if t7 = t2, then num = palindrome
            bne $t7, $t2, notpal # if t7 != t2 then num != palindrome
            jr $ra
           
   	     yespal:
   	    
   	    	addi $t8, $zero, 1  #Returns 1 if True is palindrome
   	        jr $ra
  
  
  	    notpal:
  	   	 addi $t8, $zero, 0 # Returns 0 for False for palindrome
                 jr $ra