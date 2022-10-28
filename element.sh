#!/bin/bash
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    DISPLAY_MESSAGE=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")
    if [[ -z $DISPLAY_MESSAGE ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$DISPLAY_MESSAGE" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi    
  else
    DISPLAY_MESSAGE=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
    if [[ -z $DISPLAY_MESSAGE ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$DISPLAY_MESSAGE" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
fi