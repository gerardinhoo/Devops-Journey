#!/bin/bash

# Author: Gerard Eku
# Purpose: Bash scripting fundamentals demo for DevOps practice
# Date: 2025-07-19

# Print a simple message
echo "Hola Mundo"

# Variables Definition

firstName=Gerard
lastName=Geradinho

echo "My full name is $firstName $lastName."

# Get User Input

read -p "What's your favority city in the world? " favoriteCity

echo "My favorite city in the world is $favoriteCity."

# Conditons Statements
read -p "How old are you? " age

if [ "$age" -ge 18 ]; then
  echo "You are old enough to vote."
else 
  echo "You are NOT old enough to vote."
fi

read -p "Enter a number between 1 and 10: " number
if [[ "$number" =~ ^[0-9]+$ ]] && [ "$number" -ge 1 ] && [ "$number" -le 10 ]; then
  echo "Valid number: $number"
else
  echo "Invalid input"
fi

# Loops

fruits=("orange" "mangoes" "pineapple" "bananas");
for fruit in "${fruits[@]}"; do 
  echo "Fruit: $fruit"
done

num=1;

while [ $num -le 10 ]; do
  echo "Number: $num"
  ((num++))
done

# Arithmetic Operations

read -p "first " first

read -p "second " second

result=$((first + second))

echo "result: $result"

#Working with file system
file="check_file.sh"

if [ -f $file ]; then
  echo "File does exist"
else 
  echo "File does not exist"
fi

myDir=check_dirr

if [ -d $myDir ]; then
  echo "Directory $myDir DOES EXIST"
else 
  echo "Directory $myDir DOES NOT EXIST"
fi


# Logic Operators

myNum=50
myName=Florian

if [ $myNum -gt 10 ] && [ $myName == "Floriann" ]; then
  echo "$myName is really $myNum"
else 
  echo "NOT APPLICABLE"
fi

# Functions 

fullName() {
   echo "Hello  $1 $2"
}

fullName "Marcel" "Marcelino"

sum() {
   a=10
   b=40
   result=$(( a + b ))
   echo "Result: $result"
}

sum

# Switch Cases

read -p "Hola / Bonjour / Hello: " greetings

case "$greetings" in 
  Hola)
    echo "Hola is Hi in Spanish..."
  ;;

  Bonjour)
    echo "Bonjour is good morning in French"
  ;;

  Hello)
    echo "Hello is a way to say Hi in English"
  ;;
esac







