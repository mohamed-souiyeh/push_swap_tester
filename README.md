# push_swap_tester 2.0 - to help you while you are coding it.
## Prerequisites

##### ```this is an improved version to help not in just testing, but in optimizing the algorithm too.```

first, install check_mac the root of your repository, which is where we can find your Makefile

second, go to the root of your repository, and clone this repo

```git@github.com:mohamed-souiyeh/push_swap_tester.git```
  
## how to use it

#### argument 1 is how many tests you want  
#### argument 2 the range number you want test(negative and positive number)  

### _the 3rd argument must be an integer_
#### argument 3 indecate weather you want to ```save the test_set``` used or ```use already exesting test_set```  

#### if it's positive then it saves the test_set to the file named "```test_set_(argument 3)\_for\_(argument 2)```"  

#### if it's negative then it use the test_set in the file named "```test_set_(argument 3)\_for\_(argument 2)```"  

## for example

the following command will just test 50 test_set of 5 numbers  

```./tester_push_swap 50 5```

the following command will save the test_set in test_sets/test_set_1_for_5  

```./tester_push_swap 50 5 1```   

the following command will use the test_set in test_sets/test_set_1_for_5  

```./tester_push_swap 50 5 -1```  
