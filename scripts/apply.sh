#!/bin/sh -xe
echo "applying"
git log --graph --pretty='format:%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset - %ad' --date=relative
export EXCLUDE_DIRS='^\.|scripts|bin'
DIRS=$(git --no-pager diff HEAD^..HEAD --name-only | xargs -I {} dirname {} | egrep -v "$EXCLUDE_DIRS" | uniq)
if [ -z "$DIRS" ]; then
  echo "No directories for apply."
  exit 0
fi
export CODEBUILD_SOURCE_VERSION=$(git log --merges --oneline --reverse --ancestry-path HEAD^..HEAD | grep 'Merge pull request #' | head -n 1 | cut -f5 -d' ' | sed 's/#/pr\//')
for dir in $DIRS
do
  (cd $dir && terraform init -input=false -no-color)
  #(cd $dir && terraform apply -input=false -no-color -auto-approve | ../bin/tfnotify --config ../.tfnotify.yml apply --message "$dir")
done
