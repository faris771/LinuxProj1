#!/bin/bash

#functions decleration

#fileName=

function printAll() {
    cat "$1"
    echo '-------------------------------------------------------'

}

function printSem() {
    echo 'input semester you want to print its record YEAR-YEAR/SEM#'
    echo "e.g: '2021-2022/1'"
    read sem

    echo '-------------------------------------------------------'

    while read -r line; do

        tmpSem=$(echo "$line" | cut -d ';' -f1) #checks every semester in file

        # echo "TESTING TMPSEM"
        # echo "$tmpSem"

        if [ "$tmpSem" == "$sem" ]; then
            echo "$line"
            echo '-------------------------------------------------------'

            return

        fi

    done <$1 #refrencing the file we want to read from

    echo 'SEMESTER NOT FOUND!'

}

function printAllAvg() {
    grep "EN" $1 | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" | grep -v "I" | sed 's/FA/50/' | sed 's/F/55/' >Egrades.txt
    sort -r Egrades.txt >sorted_Egrades.txt
    awk '!x[$1]++' sorted_Egrades.txt >Egrades.txt
    totalHours=0
    totalMarks=0
    weight=0
    while read -r line; do
        scndNumber=$(echo $line | cut -b 6)
        totalHours=$(($scndNumber + $totalHours))
        mark=$(echo $line | cut -d " " -f2)
        totalMarks=$(($mark * $scndNumber))
        weight=$(($totalMarks + $weight))
    done <Egrades.txt
    bc <<<"scale=2; $weight/$totalHours"

}

function printAllAvgSem() {

    echo 'input semester you want to print its record YEAR-YEAR/SEM#'
    echo "e.g: '2021-2022/1'"
    read sem

    echo '-------------------------------------------------------'

    while read -r line; do

        tmpSem=$(echo "$line" | cut -d ';' -f1) #checks every semester in file

        # echo "TESTING TMPSEM"
        # echo "$tmpSem"

        if [ "$tmpSem" == "$sem" ]; then
            echo "$line"
            echo $line | grep "EN" | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" | grep -v "I" | sed 's/FA/50/' | sed 's/F/55/' >semAvg.txt

            totalHours=0
            totalMarks=0
            weight=0
            while read -r line; do
                scndNumber=$(echo $line | cut -b 6)
                totalHours=$(($scndNumber + $totalHours))
                mark=$(echo $line | cut -d " " -f2)
                totalMarks=$(($mark * $scndNumber))
                weight=$(($totalMarks + $weight))
            done <semAvg.txt
            bc <<<"scale=2; $weight/$totalHours"

            return

        fi

    done \
        <$1 #refrencing the file we want to read from

}

function printTotalPassedHours() {

    grep "EN" $1 | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" | grep -v "I" | grep -v "F" | grep -v "FA" >tmp.txt #sed 's/FA/50/' | sed 's/FA/55/' > tmp.txt

    sort -r tmp.txt >tmp2.txt
    awk '!x[$1]++' tmp2.txt >tmp.txt

    hrs=0

    while read -r line; do
        tmp=$(echo $line | cut -b6) #the 6th byte is always the number of hours of that course e.g ENEE2321, 3 HOURS
        hrs=$(($tmp + $hrs))

    done \
        < \
        tmp.txt

    echo "total passed hours: $hrs"

}

function alotOfTalk() {                                                                                                #6 NOT SURE ABOUT THE EQUATION
    grep "EN" $1 | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" | grep -v "I" | grep -v "F" | grep -v "FA" >tmp.txt #sed 's/FA/50/' | sed 's/FA/55/' > tmp.txt
    sort -r tmp.txt >tmp2.txt
    awk '!x[$1]++' tmp2.txt >tmp.txt

    # uniq tmp2.txt > tmp.txt

    hrs=0

    while read -r line; do

        tmp=$(echo $line | cut -b6)
        hrs=$(($tmp + $hrs))

    done <tmp.txt

    total=$hrs

    grep "EN" $1 | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" | grep -v "I" >tmp.txt
    sort tmp.txt >tmp2.txt
    awk '!x[$1]++' tmp2.txt >tmp.txt #removes if u have repeated courses with the same id and different mark

    # uniq tmp2.txt > tmp.txt

    fCnt=0
    while read -r line; do

        mark=$(echo $line | cut -d " " -f2)
        hrs=$(echo $line | cut -b 6)

        if [[ $mark == "FA" ]] || [[ $mark == "F" ]]; then
            fCnt=$(($fCnt + $hrs))

        fi

    done \
        < \
        tmp.txt
    # percentage=$($total/$fCnt)

    printf "the percentage of total passed hours in relation to total F and FA "
    bc <<<"scale=2; $total/$fCnt"

}

# function printSem(){

#     echo ''

# }

function printHoursSem() {

    while read -r line; do

        tmpSem=$(echo "$line" | cut -d ';' -f1) #checks every semester in file

        if [ $tmpSem == "Year/Semester" ]; then

            continue

        fi

        echo $line | grep "EN" | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" >tmp.txt
        sort tmp.txt >tmp2.txt
        uniq tmp2.txt >tmp.txt
        hrs=0

        while read -r line2; do

            scndNumber=$(echo $line2 | cut -b 6)
            hrs=$(($hrs + $scndNumber))

        done <tmp.txt

        echo "$line"
        echo "Credit hours in this semester: "
        echo "$hrs"

        echo '-------------------------------------------------------'

    done <$1

}

function printNumTotalCourseTaken() {

    echo ''

}

function printNumLabsTaken() {

    #THIS FUNCTION PRINTS NO OF LABS TAKEN (WITHOUT REPETION) e.g IF A LAB TAKEN IN 2 SEMESTERS IT COUNTED AS 1

    grep "EN" $1 | tr -s " " " " | cut -d ";" -f2 | tr -s "," "\n" >tmp.txt #PUTS EVERY COURSE IN A LINE
    sort tmp.txt >tmp2.txt
    uniq tmp2.txt >tmp.txt
    labs=0
    while read -r line; do
        scndNumber=$(echo $line | cut -b 6)
        if [ $scndNumber -eq 1 ]; then

            labs=$(($labs + 1))

        fi

    done \
        <tmp.txt

    echo "number of labs taken in all semesters $labs"

}

function insertNewSem() { #10 FIX APPENDING ';'

    touch tmpID.txt #making this file empty
    : >tmpID.txt
    newSemString=
    numberOfHours=0

    echo 'input semester you want to add record YEAR-YEAR/SEM#'
    echo "e.g: '2022-2023/1'"
    read sem

    dash=$(echo "$sem" | cut -b5)
    divSymb=$(echo "$sem" | cut -b10)

    if [ $dash != '-' ]; then

        echo "INVALID SEMESTER"
        return

    fi

    if [ $divSymb != '/' ]; then

        echo "INVALID SEMESTER"
        return

    fi

    semFirstYear=$(echo $sem | cut -d'/' -f1 | cut -d '-' -f1)
    semScndYear=$(echo $sem | cut -d'/' -f1 | cut -d '-' -f2)

    if [[ $(echo $semFirstYear) -le 999 ]] || [[ $(echo $semFirstYear) -gt 9999 ]]; then
        echo "INVALID SEMESTER"
        return

    fi

    if [[ $(echo $semScndYear) -le 999 ]] || [[ $(echo $semScndYear) -gt 9999 ]]; then
        echo "INVALID SEMESTER"
        return

    fi

    # if echo $sem | grep -q "[0-9]{4}-[0-9]{4}/" ; then

    #     :

    # else
    #     echo "INVALID SEMESTER"
    #     return

    # fi

    lastNumInSem=$(echo $sem | cut -d '/' -f2)
    if [[ $lastNumInSem -le 0 ]] || [[ $lastNumInSem -gt 3 ]]; then

        echo "INVALID INPUT"
        echo "SEMESTER MUST BE BETWEEN 1-3 "
        return

    fi

    echo '-------------------------------------------------------'

    while read -r line; do

        tmpSem=$(echo "$line" | cut -d ';' -f1) #checks every semester in file

        # echo "TESTING TMPSEM"
        # echo "$tmpSem"

        if [ "$tmpSem" == "$sem" ]; then
            echo "SEMESTER ALREADY EXIST!"
            echo '-------------------------------------------------------'

            return

        fi

    done <$1 #refrencing the file we want to read from
    colon=";"

    newSemString+="$sem$colon "

    # newSemString+="; "#for e.g 2021-2022/2;

    echo "PLEASE INPUT NUMBER OF COURSES IN THIS SEMESTER:"

    read numberOfCourses

    while true; do

        if [ "$numberOfCourses" -eq 0 ]; then

            break

        fi

        echo "PLEASE INPUT COURSE ID e.g 'ENCS3130' "
        read courseID #try to handle misinputs

        if cat tmpID.txt | grep -q $courseID; then
            echo "COURSE ALREADY EXIST IN THIS SEMESTER! TRY OTHER COURSES.."
            continue

        fi

        courseLitters=$(echo $courseID | cut -b 1-4)
        courseNumbers=$(echo $courseID | cut -b 5-8)

        while true; do

            if [[ "$courseLitters" == "ENEE" ]] || [[ "$courseLitters" == "ENCS" ]]; then
                if [[ $courseNumbers -gt 1999 ]] && [[ $courseNumbers -lt 6000 ]]; then

                    break

                fi

            fi

            echo "INVALID COURSE ID, ID SHOULD START WITH 'ENCS' OR 'ENEE' COURSE NUMBERS SHOULD BE BETWEEN 2000-5999 "
            echo "TRY AGAIN, OR INPUT -1 TO QUIT"

            read courseID
            courseLitters=$(echo $courseID | cut -b 1-4)
            courseNumbers=$(echo $courseID | cut -b 5-8)

            if [[ $courseID -eq -1 ]]; then

                return

            fi

        done

        echo "$courseID" >>tmpID.txt

        # echo $courseID | tr -d "[a-zA-Z]"  >> tmp.txt #UTIL file

        # courseNumbers=`cat tmp.txt`

        numberOfHours=$numberOfHours+$(echo $courseNumbers | cut -b 2)

        >tmp.txt #making the file empty

        # if [ $courseNumbers -le 1999 ] || [ $courseNumbers -ge 6000 ];then

        #     echo "WRONG COURSE ID, ID SHOULD BE BETWEEN 2000-5999"

        #     return

        # fi

        echo "PLEASE INPUT COURSE MARK '60-99' OR 'F/FA/I' "
        read courseMark

        while [ "$courseMark" != "F" ] && [ "$courseMark" != "FA" ] && [ "$courseMark" != "I" ]; do

            if [ "$courseMark" -ge 100 ] || [ "$courseMark" -le 59 ]; then

                echo "INVALID MARK "
                echo "TRY AGAIN WITH VALID MARK PLEASE F, I, FA 60-99 "

                read courseMark

                continue

            fi

            break #maybe

        done

        newSemString+=$courseID
        newSemString+=" "
        newSemString+=$courseMark
        if [ $numberOfCourses -gt 1 ]; then

            newSemString+=", "

        fi

        numberOfCourses=$((numberOfCourses - 1))

    done

    if [[ $numberOfHours -le 11 ]]; then
        echo "NUMBER OF HOURS LESS THAN 12 SEMESTER CAN'T BE ADDED"
        return

    fi

    echo "SEMESTER ADDED SUCCESSFULLY"

    echo "" >>$1 #new line just in case
    echo "$newSemString" >>$1
    sed -i '/^$/d' $1 #removes empty lines from file  -i for editing file in place

}

function changeGrade() {

    echo 'in'

}

echo '-------------------------------------------------------'

echo 'WELCOME!'

echo '-------------------------------------------------------'

echo 'PLEASE INPUT FILE NAME YOU WANT TO READ OR PRESS -1 TO EXIT'

while true; do
    read fileName

    if [ "$fileName" == "-1" ]; then

        echo "THANK YOY COME AGAIN"
        exit

    fi

    if [ ! -e "$fileName" ]; then
        echo "FILE DOESN'T EXIST TRY AGAIN "
        continue

    fi

    break

done

echo '-------------------------------------------------------'
while true; do
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

    case $choice in

    \
        1) printAll $fileName ;; #ASK IF THAT'S RIGHT ?
    2) printSem $fileName ;;
    3) printAllAvg $fileName ;;
    4) printAllAvgSem $fileName;;
    5) printTotalPassedHours $fileName ;;
    6) alotOfTalk $fileName ;;
    7) printHoursSem $fileName ;; #done
    8) printNumTotalCourseTaken $fileName ;;
    9) printNumLabsTaken $fileName ;;
    10) insertNewSem $fileName ;;
    11) changeGrade ;;
    12) break ;;

    esac

done

echo 'THANK YOU '
