#!/bin/bash

RED='\033[0;31m';
WHITE='\033[0m';
GITFOLDER="./.git/"
GITUSER=$(git config user.name)
REPO=$(pwd);

if ! [[ -d $GITFOLDER ]]; then
    echo -e "The working folder: \n$REPO\ndoes not appear to be a git repository... standing down.";
    exit 1;
else
    GITREPONAME==$(echo $REPO | sed "s/^.*\///g")
    echo -e "${RED}Arming warhead...${WHITE}";
    sleep 2;
    echo -e "${RED}Warhead ready - awaiting confirmation...${WHITE}";
    echo -e "${RED}This action will permanently NUKE $REPO.${WHITE}";
    echo -e "${RED}Confirm launch? [NUKE/no]${WHITE}";
    read ANSWER
    if [ $ANSWER = "NUKE" ]; then
        echo -e "${RED}Launching... you have a 3 second abort window.${WHITE}";
        sleep 3;
        cd ..;
        rm -rf $REPO;
        echo -e "${RED}Repo nuked... rebuilding...${WHITE}";
        git clone https://github.com/$GITUSER/$GITREPONAME;
        cd $GITREPONAME;
        echo "There we go, all better now... maybe!";
        exit 0;
    else
        echo "Nuke aborted, standing down.";
        exit 0;
    fi
fi
