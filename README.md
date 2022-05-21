# push_swap_tester 2.0
## Prerequisites

install check_mac inside your push_swap working directory  
then clone the tester alongside it  
### this is an improved version to help not in just testing, but in optimizing the algorithm too.

## how to use it

#### argument 1 is how many tests you want  
#### argument 2 the range number you want test(negative and positive number)  

example ==> ./tester_push_swap 50 5  

### the third argument must be an integer
#### argument 3 indecate weather you want to save the test_set used or use already exesting one  
##### if it's positive then it saves the test_set to the file named "test_set_(argument 3)\_for\_(argument 2)"  
  
##### if it's negative then it use the test_set in the file named "test_set_(argument 3)\_for\_(argument 2)"  

example ==> ./tester_push_swap 50 5 1 -> it will save the test_set in test_sets/test_set_1_for_5  

example ==> ./tester_push_swap 50 5 -1 -> it will use the test_set in test_sets/test_set_1_for_5  
