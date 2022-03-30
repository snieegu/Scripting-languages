#!/bin/bash

function welcomeScreen() {
  Message=" ----- TIC TAC TOE -----

Game Mode:
Player vs Player

Press ' S ' to save the game
Press ' R ' to exit the game
"
  echo "$Message"
  sleep 2
  Message2="Syntax: A1, B2, C3..."
  echo "$Message2"
  grid
}

function gridInit() {
  Field=(0 1 2 3 4 5 6 7 8 9)
}

function grid() {
  clear
  GRID="
    A   B   C
  +---+---+---+
1 |${Field[1]}   |${Field[2]}   |${Field[3]}   |
  +---+---+---+
2 |${Field[4]}   |${Field[5]}   |${Field[6]}   |
  +---+---+---+
3 |${Field[7]}   |${Field[8]}   |${Field[9]}   |
  +---+---+---+
"
  echo "$GRID"
}

function initVar() {
  move=0
  finish=false
  symbol=X
  currentPlayer=1

#  cat tictactoe.sh >> temp.sh
}

function checkWin() {

  function check() {
    First="$1"
    Second="$2"
    Third="$3"

    if [[ ${Field[First]} = "$symbol" ]] && [[ ${Field[Second]} = "$symbol" ]] && [[ ${Field[Third]} = "$symbol" ]]; then
      echo "GAME OVER"
      finish=true
    fi
  }

  check 1 2 3
  check 4 5 6
  check 7 8 9
  check 1 5 9
  check 3 5 7
  check 1 4 7
  check 2 5 8
  check 3 6 9
}

function fill() {
  if [[ ${Field[$1]} = "X" ]] || [[ ${Field[$1]} = "O" ]]; then
    echo "Filed already taken"
    sleep 1
  else
    Field[$1]="$symbol"
    ((move = move + 1))
  fi
}

#function saveTemp() {
#    cat tictactoe.sh > temp.sh
#}
#
#function saveGame() {
#  echo "Name file "
#  # shellcheck disable=SC2162
#  read name
#  cat tictactoe.sh >> "$name".sh
#}
#
#function deleteTemp() {
#  rm temp.sh
#}

function engine() {

  if [ $move -gt 8 ]; then
    echo "Its a draw!"
    return 0
  fi
  if [[ $(($move % 2)) == 0 ]]; then
    chooseMessage="Player 1 (X)"
    echo "$chooseMessage"
    currentPlayer=1
    symbol=X
  else
    chooseMessage="Player 2 (O)"
    echo "$chooseMessage"
    currentPlayer=2
    symbol=O
  fi
  # shellcheck disable=SC2162
  read field

  case "$field" in
  "A1") fill 1 ;;
  "B1") fill 2 ;;
  "C1") fill 3 ;;
  "A2") fill 4 ;;
  "B2") fill 5 ;;
  "C2") fill 6 ;;
  "A3") fill 7 ;;
  "B3") fill 8 ;;
  "C3") fill 9 ;;
  "S") saveGame ;;
  "R") return 0;;
  *)
    echo "Wrong syntax try A1, B2, C3..."
    engine
    ;;
  esac
  grid
  checkWin
  if $finish; then
    if [ $currentPlayer -eq 1 ]; then
      echo "Player 1 WIN"
    else
      echo "Player 2 WIN"
    fi
    return 0
  fi
#  saveTemp
  engine
}

initVar
welcomeScreen
engine
#deleteTemp