#/bin/bash
range=0
RED='\e[1;31m'
GREEN='\e[1;32m'
BLUE='\e[1;34m'
#multiplayer setup
echo Singleplayer/Multiplayer?[S/M]
read -n 2 mode
if ! [[ $mode =~ [mM] ]]
then
    #singleplayer
    while true; do
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
else
    #multiplayer
    echo Host/connect?[H/C]
    read -n 2 hc
    if ! [[ $hc =~ [cC] ]]
    then
        echo LocalHost/Online?[L/O]
        read -n 2 lo
        if ! [[ $lo =~ [oO] ]]
        then
            for i in {9999..1000}
            do
                timeout 0.2 nc -lp $i
                [ $(echo $?) -eq 124 ] && PORT=$i && break
            done
            for i in $(seq $((PORT-1)) -1 1000)
            do
                timeout 0.2 nc -lp $i
                [ $(echo $?) -eq 124 ] && PORT2=$i && break
            done
            clear
            [ $range -eq 0 ] && read -p "Input the range: " range
            echo PORT1:$PORT
            echo PORT2:$PORT2
            nc -lp $PORT > rand.bak~
            echo $range | nc localhost $PORT2
        fi
    else
        echo PORT1?
        read -n 5 PORT
        echo PORT2?
        read -n 5 PORT2
        echo Connetion Established | nc localhost $PORT
        nc -lp $PORT2 > rand2.bak~
        range=$(cat rand2.bak~)
    fi
    while true; do
        clear
        moves=0
        inp=0
        printf "\e[1;36m"
        figlet -t -c -f pagga RANDOM NUMBER GUESSER!!!!!
        [ $range -eq 0 ] && read -p "Input the range: " range
        clear
        figlet -t -c -f pagga RANDOM NUMBER GUESSER!!!!!
        figlet -t -c -f pagga Range: 1-$range
        if ! [[ $hc =~ [cC] ]]
        then
            randomInt=$((($RANDOM % $range)+1)) 
            stat=0
            until [ $stat -eq 1 ]
            do
                echo $randomInt | nc localhost $PORT2 2>/dev/null
                [ $(echo $?) -eq 0 ] && stat=1
                sleep 1
            done
            echo Waiting for Opponnent to join...
        else
            nc -lp $PORT2 > rand2.bak~
            randomInt=$(cat rand2.bak~)
        fi
        #echo $randomInt
        until [ $inp -eq $randomInt ]; do
            printf "$BLUE""Guess the number: "
            read inp
            [ $inp -eq $randomInt ] || ([ $inp -gt $randomInt ] && echo -e "$RED" && figlet -t -f future "Too High" && echo "") || (echo -e "$RED" && figlet -t -f future "Too Low" && echo "")
            let "moves++"
        done
        echo -e "$GREEN"
        echo Waiting for opponent results....
        if ! [[ $hc =~ [cC] ]]
        then
            stat=0
            until [ $stat -eq 1 ]
            do
                echo $moves | nc localhost $PORT2 2>/dev/null
                [ $(echo $?) -eq 0 ] && stat=1
                sleep 1
            done
            nc -lp $PORT > rand.bak~
            clear
            figlet -t -c -f pagga Your Score:
            cat rand.bak~ | figlet -t -c -f pagga
            echo ""
        echo -e "$RED"
            figlet -t -c -f pagga Opponent Score:
            figlet -t -c -f pagga $moves
        else
            nc -lp $PORT2 > rand2.bak~
            stat=0
            until [ $stat -eq 1 ]
            do
                echo $moves | nc localhost $PORT 2>/dev/null
                [ $(echo $?) -eq 0 ] && stat=1
                sleep 1
            done
            clear
            figlet -t -c -f pagga Your Score:
            cat rand2.bak~ | figlet -t -c -f pagga
            echo ""
        echo -e "$RED"
            figlet -t -c -f pagga Opponent Score:
            figlet -t -c -f pagga $moves
        fi
        echo -e "$GREEN"
        read -n 1 -p "Press P to play again...." abc
        [[ $abc =~ [Pp] ]] || exit 
    done
fi
