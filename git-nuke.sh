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
    sleep 1;
    echo -e "${RED}Warhead ready - awaiting confirmation...${WHITE}";
    echo -e "${RED}This action will permanently NUKE $REPO.${WHITE}";
    echo -e "${RED}Confirm launch? [type NUKE to confirm]${WHITE}";
    read ANSWER;
    if [ $ANSWER = "NUKE" ]; then
	echo -e "Very well, ${RED}NUKE${WHITE} launched and in flight." 
        echo -e "${GREEN}Will you want to rebuild from the smouldering ashes? [y/n]${WHITE}";
        read REBUILD;
        echo -e "${RED}NUKE approaching target... you have a 3 second abort window.${WHITE}";
        sleep 2;
        cd ..;
        rm -rf $REPO;
        echo -e "\n${RED}~~~~~~~~~~~~~~${WHITE}";
        sleep 0.5;
        echo -e "${RED}~ REPO NUKED ~${WHITE}";
        sleep 0.5;
        echo -e "${RED}~~~~~~~~~~~~~~${WHITE}";
        if [ $REBUILD = "y" ]; then
            echo -e "\n${GREEN}Rebuilding...${WHITE}";
            git clone https://github.com/$GITUSER/$GITREPONAME.git;
            cd $GITREPONAME;
        fi
        echo -e "${GREEN}\nThere we go, all better now... maybe.${WHITE}";
    else
        echo -e "${GREEN}Nuke aborted, standing down.${WHITE}";
    fi
fi
exit
$SHELL
