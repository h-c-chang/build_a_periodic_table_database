#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    PERIODIC_INFO=$($PSQL "SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1")
  else
    PERIODIC_INFO=$($PSQL "SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' or name = '$1'")
  fi
  if [[ -z $PERIODIC_INFO ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$PERIODIC_INFO" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR SYMBOL BAR NAME BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi

