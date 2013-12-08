#!/bin/bash 
OK="\033[1;32mOK\033[1;39m"
FAIL="\033[1;31mFAIL\033[1;39m"
LOG=$PWD/Build.log
echo -e "\033[1;39m==== Starting Build Bot ===="

if [ -d nptool ]
  then echo -n "NPTool folder present: Fetching latest changes = " 
  cd nptool
  git pull >> $LOG 2>/dev/null 3>/dev/null
  if [ ${?}==0 ]
    then echo -e $OK
    else echo -e $FAIL
    exit 1
  fi
  cd .. 
  else echo -n "Cloning NPTool folder = " 
  git clone https://github.com/adrien-matta/nptool >> $LOG 2>/dev/null 3>/dev/null
  if [ -d nptool ]
    then echo -e $OK
    else echo -e $FAIL
    exit 1
  fi
fi


echo -n "NPLib:Configure = "
cd nptool/NPLib/
./configure >> $LOG
if [ ${?}==0 ] 
  then echo -e $OK
  else echo -e $FAIL
  exit 1
fi

echo -n "NPLib:Make = "
make >> $LOG
if [ ${?}==0 ] 
  then echo -e $OK
  else echo -e $FAIL
  exit 1
fi

# Succes
echo -e "\033[1;32m==== SUCCESSFULL BUILD ===="
exit 0 

