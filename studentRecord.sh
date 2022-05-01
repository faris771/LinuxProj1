#!/bin/bash

#functions decleration

function printAll(){
    
    echo ''
    

}  

function printSem(){
    
    echo ''
    

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

function printSem(){
    
    echo ''
    

}  
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


echo 'WELCOME!'

echo 'PLEASE INPUT FILE NAME YOU WANT TO READ'


while true
do
    read fileName
    
    
    if [ ! -e "$fileName" ]
    then
        echo "FILE DOESN'T EXIST TRY AGAIN "
        continue
        
        
        
    fi
    
    break
    
done




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
    
    read choice
    case $choice
        in
        
        0) printAll ;;
        1) printSem;;
        2) printAllAvg;;
        3) printAllAvgSem;;
        4) printTotalPassedHours;;
        5) alotOfTalk;;
        6) printSem;;
        7) printHoursSem;;
        8) printNumTotalCourseTaken;;
        9) printNumLabsTaken;;
        10) insertNewSem;;
        11) changeGrade;;
        12) break;;

    esac



done

echo 'THANK YOU '

