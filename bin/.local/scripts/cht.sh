#!/usr/bin/env bash

languages=$(echo "golang nodejs javascript typescript tmux zsh lua rust c python bash css html" | tr " " "\n")
commands=$(echo "curl wget find man tldr sed awk tr cp ls grep xargs rg ps mv kill lsof less head tail tar cp rm rename jq cat ssh cargo git git-worktree git-status git-commit git-rebase docker stow chmod chown make" | tr " " "\n")

selected=`echo "$languages\n$commands" | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if echo "$languages" | grep -qs "$selected"; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
