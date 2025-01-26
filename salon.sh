#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n ~~~~~ MY SALON ~~~~~ \n"

MAIN_MENU() {
if [[ $1 ]]
  then
    echo -e "$1"
  else 
    echo -e "Welcome to My Salon, how can I help you?\n"
fi
  echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) SERVICES_MENU ;;
    2) SERVICES_MENU ;;
    3) SERVICES_MENU ;;
    4) SERVICES_MENU ;;
    5) SERVICES_MENU ;;
    # 6) EXIT ;;
    *) MAIN_MENU "\nI could not find that service. What would you like today?" ;;
  esac
}

SERVICES_MENU(){
    # if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    #   then
    #    send to main menu 
    #   MAIN_MENU "This is not a valid service number."
    # fi

    # check phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # if customer doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
      then
        # get new customer name
        echo -e "\nI don't have a record for that number, what's your name?"
        read CUSTOMER_NAME
        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    fi 

    # get service name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    # get time for appointment
    echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?."
    read SERVICE_TIME

    # check if time is not booked

    # get customer id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # get service id
    #SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE "
    # insert appointment result 
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
    echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."

}

MAIN_MENU