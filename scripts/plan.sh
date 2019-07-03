#!/bin/sh -xe
echo "planning"
git log --graph --pretty='format:%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset - %ad' --date=relative
export EXCLUDE_DIRS='^\.|scripts'
DIRS=$(git --no-pager diff origin/master..HEAD --name-only | xargs -I {} dirname {} | egrep -v "$EXCLUDE_DIRS" | uniq)
if [ -z "$DIRS" ]; then
  echo "No directories for plan."
  exit 0
fi
for dir in $DIRS
do
  #(cd $dir && terraform plan -input=false -no-color | ../scripts/tfnotify --config ../.tfnotify.yml plan --message "$dir")
  cd $dir
  terraform init -input=false -no-color
  terraform plan -input=false 2>&1 | tee plan.log
  cd ../scripts
  cat ../$dir/plan.log | tfnotify plan --message "$dir"
done
