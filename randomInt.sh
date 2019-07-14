#!/bin/bash
range=0
RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
while [ 1 -eq 1 ]; do
    clear
    moves=0
    inp=0
    printf "\e[1;36m"
    figlet -t -c -f pagga RANDOM NUMBER GUESSER!!!!!
    [ $range -eq 0 ] && read -p "Input the range: " range
    clear
    figlet -t -c -f pagga RANDOM NUMBER GUESSER!!!!!
    figlet -t -c -f pagga Range: 1-$range
    randomInt=$((($RANDOM % $range)+1)) 
    #echo $randomInt
    until [ $inp -eq $randomInt ]; do
        printf "$BLUE""Guess the number: "
        read inp
        [ $inp -eq $randomInt ] || ([ $inp -gt $randomInt ] && echo -e "$RED" && figlet -t -f future "Too High" && echo "") || (echo -e "$RED" && figlet -t -f future "Too Low" && echo "")
        let "moves++"
    done
    echo -e "$GREEN"
    figlet -c -t -f pagga "Hurrah!!!"
    figlet -c -t -f pagga "You Guessed"
    figlet -c -t -f pagga "it in"
    figlet -c -t -f pagga "$moves Moves"
    read -n 1 -p "Press P to play again...." abc
    [[ $abc =~ [Pp] ]] || exit 
done
