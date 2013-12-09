#!/bin/bash 
OK="\033[1;32mOK\033[1;39m"
FAIL="\033[1;31mFAIL\033[1;39m"
LOG=$PWD/Deploy.log
echo -e "\033[1;39m==== Starting Deploy ===="

echo  "== Updating NPTool == "
if [ ! [ -z "$NPTOOL" ] ];
   then echo -e "Update " $FAIL " no NPTool environment"
   exit 1 
fi

cd $NPTool/NPLib
echo -n "NPLib: Fetching latest changes"
git pull >> $LOG 2>/dev/null 3>/dev/null
  if [ ${?}==0 ]
    then echo -e $OK
    else echo -e $FAIL
    exit 1
 fi

echo -n "NPLib:Configure = "
make distclean
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

echo  "== Updating Ganil2Root == "
if [ ! [ -z "$GANIL2ROOT" ] ]
   then echo -e "Update " $FAIL " no Ganil2Root environment"
   exit 1 
fi

cd $GANIL2ROOT/libs
echo -n "Ganil2Root: Fetching latest changes"
git pull >> $LOG 2>/dev/null 3>/dev/null
  if [ ${?}==0 ]
    then echo -e $OK
    else echo -e $FAIL
    exit 1
 fi

echo -n "Ganil2Root:Make = "
cd libs
make >> $LOG
if [ ${?}==0 ] 
  then echo -e $OK
  else echo -e $FAIL
  exit 1
fi

echo  "== Updating GUser == "
MANIP=$USERNAME
if [ ![ -d ~/ganacq_manip/$USERNAME/GRU/GRUscripts] ]
 then echo "No standard path for GRUscripts found = " $FAIL
 exit 1 
fi

cd ~/ganacq_manip/$USERNAME/GRU/GRUscripts
git pull >> $LOG 2>/dev/null 3>/dev/null
if [ ${?}==0 ] 
  then echo -e $OK
  else echo -e $FAIL
  exit 1
fi
make >> $LOG
if [ ${?}==0 ] 
  then echo -e $OK
  else echo -e $FAIL
  exit 1
fi

# Succes
echo -e "\033[1;32m==== Deploy Successfull===="
exit 0 

