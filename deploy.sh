chmod 600 id_rsa
scp -o StrictHostKeyChecking=no -i id_rsa docker-compose.yml $1:$3
ssh -o StrictHostKeyChecking=no -i id_rsa $1 "printenv; cd $3; docker-compose stop $2; docker-compose pull $2; docker-compose up -d $2"
