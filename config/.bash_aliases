function composer() {
  docker-compose exec --user $USER web composer --working-dir=$PWD "$@"
}

alias dc="docker-compose"
alias brunch="docker-compose exec --user $USER web brunch"
alias npx="docker-compose exec --user $USER web npx"
alias npm="docker-compose exec --user $USER web npm"
alias yarn="docker-compose exec --user $UID:`id -g $USER` web yarn"
alias node="docker-compose exec --user $UID:`id -g $USER` web node"
alias mongo="docker-compose --file ~/vm_config/docker-compose.yml  exec mongo mongo"
alias redis-cli="docker-compose --file ~/vm_config/docker-compose.yml  exec redis redis-cli"
alias mysql="docker-compose --file ~/vm_config/docker-compose.yml exec -T mysql mysql"
alias fix='bin/web-cs-fixer fix'

#Alexa command
alias ask="docker-compose exec --user $USER web ask"
alias bst="docker-compose exec --user $USER web node /var/www/alexa-nrj-radio/node_modules/bespoken-tools/bin/bst.js"
alias lambda-local="docker-compose exec --user $USER web node_modules/lambda-local/bin/lambda-local -l lambda/src/index.js -h handler -e event.json"
alias tsc="docker-compose exec --user $USER web tsc"
alias tsc_build="docker-compose exec --user $USER web tsc --build lambda/tsconfig.json"
