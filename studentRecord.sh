#!/bin/bash

#functions decleration

#fileName=

function printAll(){
    cat "$1"     
    echo '-------------------------------------------------------'



}  

function printSem(){
    echo 'input semester you want to print its record YEAR-YEAR/SEM#'
    echo "e.g: '2021-2022/1'"
    read sem 

    echo '-------------------------------------------------------'
    
    while read -r line;do
        
        tmpSem=$(echo "$line" | cut -d ';' -f1)  #checks every semester in file
        
        # echo "TESTING TMPSEM"
        # echo "$tmpSem"
        
        if [ "$tmpSem" == "$sem" ];then
            echo "$line"
            echo '-------------------------------------------------------'

            return

        fi

    done < $1 #refrencing the file we want to read from 


    echo 'SEMESTER NOT FOUND!'


    

}  

function printAllAvg(){
    
    echo ''
    
}  

function printAllAvgSem(){
    
    echo ''
    

}  

function printTotalPassedHours(){
    
    echo ''
    

}

function alotOfTalk(){ #6
    
    echo ''
    

}  

# function printSem(){
    
#     echo ''
    

# }  

function printHoursSem(){
    
    echo ''
    

}  

function printNumTotalCourseTaken(){
    
    echo ''
    

}  

function printNumLabsTaken(){
    
    echo ''
    
}  
function insertNewSem(){
    
    echo ''
    

}  
function changeGrade(){
    
    echo ''
    

}  

echo '-------------------------------------------------------'

echo 'WELCOME!'

echo '-------------------------------------------------------'


echo 'PLEASE INPUT FILE NAME YOU WANT TO READ OR PRESS -1 TO EXIT'


while true
do
    read fileName
    
    if [ "$fileName" == "-1" ];then

        echo "THANK YOY COME AGAIN"
        exit

    fi
    
    if [ ! -e "$fileName" ]
    then
        echo "FILE DOESN'T EXIST TRY AGAIN "
        continue
        
        
        
    fi
    
    break
    
done



echo '-------------------------------------------------------'
while true

do
    echo '1. Show or print student records (all semesters).'
    echo '2. Show or print student records for a specific semester.'
    echo '3. Show or print the overall average.'
    echo '4. Show or print the average for every semester.'
    echo '5. Show or print the total number of passed hours.'
    echo '6. Show or print the percentage of total passed hours in relation to total F and FA hours.'
    echo '7. Show or print the total number of hours taken for every semester.'
    echo '8. Show or print the total number of courses taken.'
    echo '9. Show or print the total number of labs taken.'
    echo '10. Insert the new semester record.'
    echo '11. Change in course grade.'
    echo '12. EXIT'
    echo '-------------------------------------------------------'
    read choice

    case $choice
        in
        
        1) printAll $fileName ;; #ASK IF THAT'S RIGHT ?
        2) printSem $fileName ;;
        3) printAllAvg;;
        4) printAllAvgSem;;
        5) printTotalPassedHours;;
        6) alotOfTalk;;
        7) printHoursSem;;
        8) printNumTotalCourseTaken;;
        9) printNumLabsTaken;;
        10) insertNewSem;;
        11) changeGrade;;
        12) break;;

    esac



done

echo 'THANK YOU '

