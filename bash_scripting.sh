#!/bin/bash

# for number in {1..4}; do
#   echo $number
# done


# count=5

# while [ $count -ge 1 ]; do 
#   echo $count
#   ((count--))
# done

# count=1
# until [ $count -gt 5 ]; do
#   echo "Count is $count"
#   ((count++))
# done

# greet() {
#   name=$1
#   age=$2
#   origin=$3
#   echo "Hello, $name! You're $age. From $origin"
# }
# greet Aliceviiiii 30 Brazil

my_array=("value1" "value2" "value3")

echo ${my_array[@]}

my_array[1]="new_value"


echo ${my_array[@]}

