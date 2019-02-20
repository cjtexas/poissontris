chmod 600 id_rsa
scp -o StrictHostKeyChecking=no -i id_rsa docker-compose.yml ubuntu@poissontris.linards.net:~/
ssh -o StrictHostKeyChecking=no -i id_rsa ubuntu@poissontris.linards.net "docker-compose rm -fs $1; docker-compose pull $1; docker-compose up -d $1"
