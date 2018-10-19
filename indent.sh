#! /bin/bash

function hasInstalled() {
    which $(eval echo $1) >&/dev/null
    status=$(echo $?)

    if [ $status = 1 ]; 
    then
       echo "no"
    fi
}

if [[ $(hasInstalled node) = "no" ]];
then
   echo "node has not been installed. please installed it first."
fi

if [[ $(hasInstalled eslint) = "no" ]]; 
then
   echo "eslint has not been installed, now we are installing it for you..."
   npm install -g eslint
fi

function isNumber() {
   local regexp='^[0-9]+$'
   if [[ $1 =~ $regexp ]]; 
   then
      echo "yes"
   fi 
}

function isJavaScriptFile() {
   if [[ "${1##*.}" = "js" ]];
   then
      echo "yes"
   fi
}

if [[ $(isNumber $1) = "yes" ]] && [[ $(isJavaScriptFile $2) = "yes" ]];
then
   indentation=$1
   file=$2
elif [[ $(isNumber $2) = "yes" ]] && [[ $(isJavaScriptFile $1) = "yes" ]];
then
   indentation=$2
   file=$1
else
   echo -e "Usuage: indent number filename Or indent filename number"; exit 1
fi


eslint  --fix \
        --env "browser,node"\
        --parser-options "{ecmaVersion: 2018,sourceType: module}"\
        --rule "indent: [error, $indentation]" $file