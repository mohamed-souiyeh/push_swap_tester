#!/bin/sh

RESET="\033[0m"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

#test set
#g ../push_swap.c
cp ../push_swap .
cp ../checker_Mac .
if ! [ -e ./test_sets/ ];
then
	mkdir test_sets
fi
function push_swap()
{
	TEST1=$(./push_swap $@ | ./checker_Mac $@)
	LENINC=$(./push_swap $@ | wc -l)

	if [ "$TEST1" == "OK" ]
	then
		printf " $BLUE%s\n$RESET" "================="
		printf " $GREEN%s$@\n$RESET\n"
		printf "$GREEN\n%s$RESET" "stats = OK"
		printf "\n%s %d\n$RESET" "operations ==" $LENINC
		printf " $BLUE%s\n$RESET" "================="
	elif [ "$TEST1" == "KO" ]
	then
		echo "$TEST1"
		printf "$RED%s$RESET\n" "============="
		printf "$RED%s$@$RESET\n" "stats = KO in ==> "
		printf "$RED%s$RESET\n" "============="
	elif [ "$TEST1" == "Error" ]
	then
		printf "$RED%s$RESET\n" "============="
		printf "$RED%s$@\n$RESET" "ERROR"
		printf "$RED%s$RESET\n" "============="
	fi
}

function test_push
{
	i="0"
	while [ $i != $1 ]; 
	do
		ARG=$(python3 ./test.py $2)
		printf "$YELLOW%s%d$RESET\n" "test for ===> " "$2"
		push_swap $ARG
		i=$[$i+1];
	done
}

function test_push_save
{
	i="0"
	> "test_sets/test_set_$3_for_$2"
	while [ $i != $1 ]; 
	do
		ARG=$(python3 ./test.py $2)
		echo "$ARG" >> "test_sets/test_set_$3_for_$2"
		printf "$YELLOW%s%d$RESET\n" "test for ===> " "$2"
		push_swap $ARG
		i=$[$i+1];
	done
}

function test_push_from
{
	i="0"
	nbr=$(echo -"($3)" | bc -l | cat)
	while [ $i != $1 ]; 
	do
		i=$[$i+1];
		ARG=$(sed -n "$i"p "test_sets/test_set_${nbr}_for_$2")
		printf "$YELLOW%s%d$RESET\n" "test for ===> " "$2"
		push_swap $ARG
	done
}

#test_set_$3_for_$2
#argument  arg1 = how much while loop and arg2 = how much number gnrate
#test_all $1 $2
function test_all()
{
	echo "<=======================> start $2 number <=================>"
	if [ $# -eq 2 ]
	then
		test_push $1 $2
	fi

	if [ $3 -gt 0 ]
	then
		test_push_save $1 $2 $3
	fi

	if [ $3 -lt 0 ]
	then
		test_push_from $1 $2 $3
		exit 0
	fi
	echo "<=======================> end $2 number <===================>"
}

if [ $# -eq 3 ] && [ $3 -lt 0 ]
then
	file=$(echo -"($3)" | bc -l | cat)
	if ! [ -f ./test_sets/test_set_${file}_for_$2 ];
	then
		echo "the file: test_sets/test_set_${file}_for_$2 doesn't exist."
		exit 1
	fi
fi

if [ $# -eq 3 ] && [ $3 -ne 0 ]
then
	ALL=$(test_all $1 $2 $3 | cat)
elif [ $# -eq 2 ] || [ $3 -eq 0 ]
then
	ALL=$(test_all $1 $2 | cat)
fi

echo "$ALL"
SUCSS=$(echo "$ALL" | grep "stats = OK" | wc -l | awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many success == > ✓ $GREEN%d$RESET\n" "$SUCSS"
FAIL=$(echo "$ALL" | grep "stats = KO" | wc -l |  awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many fail    == > ✗ $RED%d$RESET\n" "$FAIL"
FAIL_E=$(echo "$ALL" | grep "ERROR" | wc -l |  awk -F ' ' '{print}' | xargs echo)
printf "$YELLOW how many ERRORS  == > ✗ $RED%d$RESET\n" "$FAIL_E"
NUMBER=$(echo "$ALL" | grep "operations == " | grep -Eo '[0-9]+'| awk -F '\n' '{print}'| xargs | cat)

printf "$YELLOW ======>  result <==== $RESET  \n"
for n in $NUMBER;
do
    ((max < n)) && max=$n
done
min=$max
for m in $NUMBER;
do
	((min > m)) && min=$m
done
printf "$MAGENTA ======>  min number you have  ===> || ==> %d <==||$RESET\n" "$min"
printf "$MAGENTA ======>  max number you have  ===> || ==> %d <==||$RESET\n" "$max"