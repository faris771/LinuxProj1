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
    cnt=0
    total=0
    
    while read -r line;do
        
        tmpLine=$(echo "$line" | cut -d ';' -f1)  #checks every semester in file
        
        if [ "$tmpLine" == "Year/Semester" ];then
            
            continue

        fi
        


    done 



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
function insertNewSem(){ #10

    newSemString=
    numberOfHours=0
        
    echo 'input semester you want to add record YEAR-YEAR/SEM#'
    echo "e.g: '2022-2023/1'"
    read sem 

    echo '-------------------------------------------------------'
    
    while read -r line;do
        
        tmpSem=$(echo "$line" | cut -d ';' -f1)  #checks every semester in file
        
        # echo "TESTING TMPSEM"
        # echo "$tmpSem"
        
        if [ "$tmpSem" == "$sem" ];then
            echo "SEMESTER ALREADY EXIST!"
            echo '-------------------------------------------------------'

            return

        fi

    done < $1 #refrencing the file we want to read from 
    
    newSemString+=$sem
    
    
    newSemString+="; "#for e.g 2021-2022/2; 

    echo "PLEASE INPUT NUMBER OF COURSES IN THIS SEMESTER:"

    read numberOfCourses


    while true;do
        
        if [ "$numberOfCourses" -eq 0 ];then

            break

        fi

        echo "PLEASE INPUT COURSE ID e.g 'ENCS3130' "
        read courseID     #try to handle misinputs

        courseLitters=$(echo $courseID | cut -b 1-4 )
        
        if [ "$courseLitters" != "ENEE" ] && [ "$courseLitters" != "ENCS" ];then

            echo "INVALID COURSE ID "
            return

        fi
        
        echo $courseID | tr -d "[a-zA-Z]"  >> tmp.txt #UTIL file
        
        courseNumbers=`cat tmp.txt`
        numberOfHours=$numberOfHours+$(echo $courseNumbers | cut -b 2 )
        

        >tmp.txt    #making the file empty

        if [ $courseNumbers -le 1999 ] || [ $courseNumbers -ge 6000 ];then

            echo "WRONG COURSE ID"
            
            return


        fi


        echo "PLEASE INPUT COURSE MARK '60-99' OR 'F/FA/I' "
        read courseMark

        if [ "$courseMark" != "F" ] && [ "$courseMark" != "FA" ] && [ "$courseMark" != "I" ];then

            if [ "$courseMark" -ge 100 ] || [ "$courseMark" -le 59 ];then

                echo "INVALID MARK "



            fi


        fi

        newSemString+=$courseID
        newSemString+=" "
        newSemString+=$courseMark
        newSemString+=", "

        

        numberOfCourses=$((numberOfCourses-1))

    done

    if [ $numberOfHours -le 11 ];then
        echo "NUMBER OF HOURS LESS THAN 12 SEMESTER CAN'T BE ADDED"
        return


    fi

    echo "SEMESTER ADDED SUCCESSFULLY"
    echo "$newSemString" >> $1


    

}  

function changeGrade(){
    
    echo 'in'
    

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
        10) insertNewSem  $fileName;;
        11) changeGrade;;
        12) break;;

    esac



done

echo 'THANK YOU '

