chmod 600 id_rsa
scp -o StrictHostKeyChecking=no -i id_rsa docker-compose.yml $1:~/
ssh -o StrictHostKeyChecking=no -i id_rsa $1 "docker-compose rm -fs $2; docker-compose pull $2; docker-compose up -d $2"
