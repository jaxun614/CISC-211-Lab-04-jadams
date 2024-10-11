/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Jackson Adams"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* set values of transaction, eat_out, stay_in, eat_ice_cream, we_have_a_problem to 0 */
    
    /* DON'T TOUCH R0!!! that is where the balance is */
    ldr r1, =0 /* move 0 into r1 */
    
    /* r2 is the register that addresses will be move in and out of */
    ldr r2, =transaction /* write the address of transaction to r2 */
    str r0, [r2] /* write r1 (the balance) in the memory address of transaction */
    
    ldr r2, =eat_out /* write the address of eat_out to r2 */
    str r1, [r2] /* write 0 in the memory address of eat_out */
    
    ldr r2, =stay_in /* write the address of stay_in to r2 */
    str r1, [r2] /* write 0 in the memory address of stay_in */
    
    ldr r2, =eat_ice_cream /* write the address of eat_ice_cream to r2 */
    str r1, [r2] /* write 0 in the memory address of eat_ice_cream */
    
    ldr r2, =we_have_a_problem /* write the address of we_have_a_problem to r2 */
    str r1, [r2] /* write 0 to the memory address of we_have_a_problem */
    ldr r2, =0
    
    /* Check if the transaction is greater than 1000 */
    ldr r1, =1000 /* write 1000 to r1 */
    
    cmp r0, r1 /* compair r0-r1, if r0 is greater than 1000 */
    bgt yes /* take this path if r0 is greater than 1000 */
    /* r0 was not greater than 1000 */
    cmp r1, r0 /* compair r1-r0, if r0 is less than -1000 */
    blt yes /* take this path if r0 is less than -1000 */ 
    
    /* the transaction was withing the acceptable range */
    temp_balance: .word 0 /* allocate space for a temp variable */

    ldr r2, =transaction /* write the mem address of transaction in r2*/
    ldr r3, [r2] /* write the value of transaction in r3 */
    adds r5, r0, r3 /* add balance and transaction then write the value in r5 and set the flags */
    ldr r2, =temp_balance /* write the mem address of temp_balance to r2 */
    str r4, [r2] /* write the value of r4 to the mem location of temp_balance */
    bvs yes /* take this path if the value overflows */
    b a /* take this path otherwise */
    
    yes:
    /* set the transaction to 0 */ 
    ldr r1, =0
    ldr r2, =transaction
    str r1, [r2]
    /* update we_have_a_problem */
    ldr r1, =1
    ldr r2, =we_have_a_problem
    str r1, [r2]
    /* update r0 to balance */
    ldr r2, =balance
    ldr r0, [r2]
    b done

    /**/
    a:
    mov r0, r5 /* set the balance to the value of the temp value */
    ldr r1, =0 /* write 0 to r1 */
    cmp r0, r1 /* comair balance with 0 */
    bgt money_time /* take this path when balance is greater than 0 */
    blt not_money_time /* take this bath when balance is less than 0 */
    
    ldr r1, =1
    ldr r2, =eat_ice_cream
    str r1, [r2]
    b done
    
    
    money_time:
    ldr r1, =1
    ldr r2, =eat_out
    str r1, [r2]
    
    //ldr r2, =balance
    //ldr r0, r2
    //b done
    
    not_money_time:
    //ldr r1, =1
    //ldr r2, =stay_in
    //str r1, [r2]
    
    //ldr r2, =balance
    //ldr r0, r2
    //b done
    
    
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




