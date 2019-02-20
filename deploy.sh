chmod 600 id_rsa;
scp -o StrictHostKeyChecking=no -i id_rsa docker-compose.yml ubuntu@poissontris.linards.net:~/
if [ "$TRAVIS_BRANCH" == "master" ]; then SERVICE=poissontris; SERVICE=poissontris-"$TRAVIS_BRANCH"; fi
ssh -o StrictHostKeyChecking=no -i id_rsa ubuntu@poissontris.linards.net "docker-compose down; docker-compose -d up $SERVICE"
