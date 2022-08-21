#! /usr/bin/env bash

# run this to store creds -> git config credential.helper store
# echo "VAULT_PATH=$(pwd)" > .env
# export all values from .env file 
if [ -f .env ]
then
  export "$(cat .env | xargs)" 
fi

# VAULT_PATH exported from .env
cd $"VAULT_PATH" || exit

# check for any un commited changes
CHANGES="$(git status --porcelain=v1 2>/dev/null | wc -l)"g

# exit if no changes
if [ "$CHANGES" -eq 0 ]
then
    exit
fi

TIME_NOW=$( date +"%m-%d-%Y_%T_%Z" )

# pull any new remote changes
git pull
# stage any new local changes
git add .
# commit with the message as the current date, time and timezone
git commit -q -m "$TIME_NOW"
# push w/o any output
git push -q