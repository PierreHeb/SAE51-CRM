docker compose up -d
docker run dokku/wait -c crm-bdd:3306 
docker cp users.csv crm-bdd:/users.csv
docker cp insertion_data.sh crm-bdd:/insertion_data.sh
docker exec -it crm-bdd /insertion_data.sh
