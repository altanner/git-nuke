#!/bin/bash

RED="\033[31m";
GREEN="\033[32m";
WHITE="\033[0m";
GITFOLDER="./.git/"
GITUSER=$(git config user.name);
REPO=$(pwd);

if ! [[ -d $GITFOLDER ]]; then
    echo -e "${RED}Nuke target NOT acquired.${WHITE}";
    echo -e "The working folder: \n$REPO\ndoes not appear to be a git repository: ${GREEN}standing down.${WHITE}";
    exit 1;
else
    GITREPONAME=$(echo $REPO | sed "s/^.*\///g")
    echo -e "${RED}Nuke target $REPO acquired.${WHITE}";
    echo -e "${RED}Arming warhead...${WHITE}";
    sleep 2;
    echo -e "${RED}Warhead ready - awaiting confirmation...${WHITE}";
    echo -e "${RED}This action will permanently NUKE $REPO.${WHITE}";
    echo -e "${RED}Confirm launch? [NUKE/no]${WHITE}";
    read ANSWER;
    if [ $ANSWER = "NUKE" ]; then
        echo -e "${GREEN}Would you like to rebuild from the smouldering ashes? [y/n]";
        read REBUILD;
        echo -e "${RED}Launching... you have a 3 second abort window.${WHITE}";
        sleep 3;
        cd ..;
        rm -rf $REPO;
        echo -e "${RED}~~~~~~~~~~~~~~${WHITE}";
        sleep 1;
        echo -e "${RED}~ REPO NUKED ~${WHITE}";
        sleep 1;
        echo -e "${RED}~~~~~~~~~~~~~~${WHITE}";
        if [ $REBUILD = "y" ]; then
            echo -e "${GREEN}Rebuilding...${WHITE}";
            git clone https://github.com/$GITUSER/$GITREPONAME.git;
            cd $GITREPONAME;
        fi
        echo -e "${GREEN}\nThere we go, all better now... maybe.${WHITE}";
        exit 0;
    else
        echo -e "${GREEN}Nuke aborted, standing down.${WHITE}";
        exit 0;
    fi
fi
