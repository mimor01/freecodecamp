#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN() {
  if [[ -z $1 ]]; then
      echo -e "Please provide an element as an argument."
    elif [[ "$1" =~ ^[0-9]+$ ]]; then
      #argument is atomic number
      ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number = '$1'")
        ELEMENT_OUTPUT $ELEMENT_INFO
    elif [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
      #argument is a symbol or name
      ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.symbol = '$1' OR e.name = '$1'")
        ELEMENT_OUTPUT $ELEMENT_INFO
  fi
}

ELEMENT_OUTPUT() {
  if  [[ -z $ELEMENT_INFO ]]; then
    echo "I could not find that element in the database."
      else
      echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE
        do echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
  fi
}

MAIN "$1"