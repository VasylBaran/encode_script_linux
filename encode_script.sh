#!/bin/bash
#Handbrake batch script to recursively encode every file in a certain directory


function check
{
oldsize=`wc -c <"$f"`
sleep 1
newsize=`wc -c <"$f"`

while [ "$oldsize" -lt "$newsize" ]
do
 echo "Not yet..."
oldsize=`wc -c <"$f"`
sleep 1
newsize=`wc -c <"$f"`
done

if [ "$oldsize" -eq "$newsize" ]
then
   echo "The file has been copied completely."
fi
}

FILES="/home/usr/Documents/Watch/*"
PRESET="-e x264 -q 20 --x264-preset veryfast"

#//////////////////////////////////////////
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3
#exec 1>LOGFILE 2>&1
#//////////////////////////////////////////

function main
{
for f in $FILES
do

##################################################

 
 #printf "Current date and time %s\n" "$now"
##################################################

if [[ $f =~ \.mp4$ ]];
then
#/////////////////////////////////////////////////////////////////////


 g="${f/mp4/mkv}"
 g=${g/"Watch"/"Output"}
 LOG_FILE="${g/mkv/log}"
 exec > >(tee -a "${LOG_FILE}" )
 exec 2> >(tee -a "${LOG_FILE}" >&2)

 now="$(date)"
 printf "Current date and time %s\n" "$now"

  check
   

  
   echo "Processing ${f} file..."

   HandBrakeCLI -i "${f}" -o "${g}" "$PRESET"
   rm "$f"
     
  
fi
#/////////////////////////////////////////////////////////////////////

if [[ $f =~ \.avi$ ]];
then

  

  g="${f/avi/mkv}"
  g=${g/"Watch"/"Output"}
  LOG_FILE="${g/mkv/log}"
  exec > >(tee -a "${LOG_FILE}" )
  exec 2> >(tee -a "${LOG_FILE}" >&2)

  now="$(date)"
  printf "Current date and time %s\n" "$now"

  check


  
   echo "Processing ${f} file..."

   HandBrakeCLI -i "${f}" -o "${g}" "$PRESET"
   rm "$f"
  
fi

if [[ $f =~ \.mov$ ]];
then

  g="${f/mov/mkv}"
  g=${g/"Watch"/"Output"}
  LOG_FILE="${g/mkv/log}"
  exec > >(tee -a "${LOG_FILE}" )
  exec 2> >(tee -a "${LOG_FILE}" >&2)

  now="$(date)"
  printf "Current date and time %s\n" "$now"

   check


  
   echo "Processing ${f} file..."

   HandBrakeCLI -i "${f}" -o "${g}" "$PRESET"
   rm "$f"
  
fi

done
#if [ "$(ls -A /home/usr/Documents/Watch/)" ]; then
#main
#fi
}
if [ "$(ls -A /home/usr/Documents/Watch/)" ]; then
main
fi
exit

