#!/bin/bash
range=0
inp=0
moves=1
RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
echo RANDOM NUMBER GUESSER!!!!!
read -p "Input the range: " range
randomInt=$((($RANDOM % $range)+1)) 
#echo $randomInt
until [ $inp -eq $randomInt ]; do
    printf "$BLUE""Guess the number: "
    read inp
    [ $inp -eq $randomInt ] || ([ $inp -gt $randomInt ] && echo -e "$RED" && toilet -t --font future "It is less than $inp") || (echo -e "$RED" && toilet -t --font future "It is greater than $inp")
    let "moves++"
done
echo -e "$GREEN""Hurrah!!! You Guessed it in $moves Moves"
read -p "Press enter to continue...." abc
