#!/bin/bash
range=0
inp=0
moves=0
RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
while [ 1 -eq 1 ]; do
    clear
    printf "\e[1;36m"
    figlet -t -c -f pagga RANDOM NUMBER GUESSER!!!!!
    [ $range -eq 0 ] && read -p "Input the range: " range
    figlet -t -c -f pagga Range: 1-$range
    randomInt=$((($RANDOM % $range)+1)) 
    #echo $randomInt
    until [ $inp -eq $randomInt ]; do
        printf "$BLUE""Guess the number: "
        read inp
        [ $inp -eq $randomInt ] || ([ $inp -gt $randomInt ] && echo -e "$RED" && toilet -t --font future "Too High" && echo "") || (echo -e "$RED" && toilet -t --font future "Too Low" && echo "")
        let "moves++"
    done
    echo -e "$GREEN" && toilet -t --font pagga "Hurrah!!!"
    toilet -t --font pagga "You Guessed"
    toilet -t --font pagga "it in"
    toilet -t --font pagga "$moves Moves"
    read -n 1 -p "Press P to play again...." abc
    [[ $abc =~ [Pp] ]] || exit 
done
