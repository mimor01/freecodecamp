#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n~~~~~ Number guessing game ~~~~~\n"

MAIN() {

  echo "Enter your username:"
  read USERNAME

  CHECK_USERNAME $USERNAME

  GUESS_NUMBER_LOGIC

}

GUESS_NUMBER_LOGIC() {

  SECRET_NUMBER=$((RANDOM % 1000 + 1))
  #helper, by default comment next time!
  echo "Secret number is $SECRET_NUMBER."

  COUNT=0
  GUESS=0
  
  echo -e "\nGuess the secret number between 1 and 1000:"
  
  while (( GUESS!=SECRET_NUMBER)); do
  read GUESS
    if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
      echo -e "\nThat is not an integer, guess again:"
      continue
    fi

    COUNT=$(( $COUNT+1 ))
    if (( GUESS>SECRET_NUMBER )); then 
      echo -e "\nIt's higher than that, guess again:"
    elif (( GUESS<SECRET_NUMBER )); then
      echo -e "\nIt's lower than that, guess again:"
    else
      echo -e "\nYou guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
      UPDATE_GAME_STATS=$($PSQL "UPDATE game_info SET games_played = games_played + 1, best_game = LEAST(best_game, $COUNT) WHERE username='$USERNAME'")
      break
    fi   
  done
  }

CHECK_USERNAME() {

  if [[ ! -z $USERNAME ]]; then
      USERNAME_RESULT=$($PSQL "SELECT username, games_played, best_game FROM game_info WHERE username = '$USERNAME'")
      # GAMES_PLAYED=$($PSQL "SELECT games_played FROM game_info WHERE username = '$USERNAME'") 
      # BEST_GAME=$($PSQL "SELECT best_game FROM game_info WHERE username = '$USERNAME'")
    if [[ ! -z $USERNAME_RESULT ]]; then 
      USERNAME_RESULT_CLEAN=$(echo "$USERNAME_RESULT" | sed 's/ |/|/g' | sed 's/| /|/g')
      IFS='|' read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$USERNAME_RESULT_CLEAN"
      echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    else 
      echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
      INSERT_USERNAME=$($PSQL "INSERT INTO game_info(username, games_played) VALUES('$USERNAME', 0)")
    fi 
  fi
}

MAIN