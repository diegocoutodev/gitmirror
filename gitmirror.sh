#!/bin/bash

urlencode() {
  for i in $(seq 0 $((${#1} - 1))); do
    char="${1:i:1}"
    case $char in
    [A-Za-z0-9.~_-])
      printf "$char"
      ;;
    *)
      printf "$char" | xxd -pc1 | while read coded; do printf "%%%s" "$coded"; done
      ;;
    esac
  done
}

if [ -z $1 ]; then
  echo "Please set an environment file by command line"
  exit
fi

source $1

if [ -z $2 ]; then
  DATA_DIR=${HOME}/repositories
  mkdir -p ${DATA_DIR}
  echo "Default diretory: ${DATA_DIR}"
else
  DATA_DIR=$2
fi

formaturl() {
  echo $(echo $1 | sed -e "s|\(://\)|\1$2:$3@|g")
}

giturl() {
  URL=$1
  if [ ! -z $3 ]; then
    URL=$(formaturl $1 $2 $3)
  fi
  echo ${URL}
}

cd $DATA_DIR

if [ ! -d $(basename ${SOURCE_REPO}) ]; then
  git clone --mirror $(giturl ${SOURCE_REPO} ${SOURCE_USER} $(urlencode ${SOURCE_PASS}))
fi

cd $(basename ${SOURCE_REPO})

# Update local repository
git fetch --all

# Push into remote repository
git push --mirror $(giturl ${TARGET_REPO} ${TARGET_USER} $(urlencode ${TARGET_PASS}))

cd - >/dev/null
