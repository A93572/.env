#!/bin/bash
sessionName=$1
openSessions=`tmux ls | awk -F: '{ print $1 }'`
sessionEsists=0

for session in ${openSessions[@]}
do
    if [[ ${session} == ${sessionName} ]]
    then
        sessionEsists=1
    fi
done

if [[ ${sessionEsists} == 1 ]]
then
    echo "Attaching to existing session ${sessionName}"
    sleep 1
    tmux a -t "${sessionName}"
else
    case ${sessionName} in
        dev) echo "Dev tmux script" ;;
        home)  echo "Home tmux script" ;;
        *) tmux new-session -n ${sessionName} ;;
    esac
fi

