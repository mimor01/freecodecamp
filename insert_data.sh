#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $WINNER != winner ]]
    then
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$WINNER')")
    # if not found
      if [[ -z $TEAM_ID ]]
        then
        # insert winner
        INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
          if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
            then 
            echo Inserted into teams, $WINNER
            TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$WINNER')")
          fi
        # get new team_id
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$WINNER')")    
      fi
  fi
  if [[ $OPPONENT != opponent ]]
    then
    #get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$OPPONENT')")
    #if not found
      if [[ -z $TEAM_ID ]]
        then
        #insert opponent
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
          if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
            then 
            echo Inserted into teams, $OPPONENT
          fi
        #get new team_id
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$OPPONENT')")
      fi
  fi    
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $YEAR != year ]]
    then
      # get winner_id and opponent_id from teams table and insert into table games all related records
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$WINNER')")
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name=('$OPPONENT')")
      INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES('$YEAR', '$ROUND', '$WINNER_GOALS', '$OPPONENT_GOALS', '$WINNER_ID', '$OPPONENT_ID')")
        echo "Inserted into games, $YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID"
  fi
done