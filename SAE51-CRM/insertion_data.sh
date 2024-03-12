#!/bin/bash

# Configuration de la base de données
DB_USER="root"
DB_NAME="dolibarrbase"


while IFS=";" read -r Id Identifiant MDP Prenom NOM Ville
do
	mysql -u $DB_USER -p"root" $DB_NAME <<EOF
	INSERT INTO llx_user (\`rowid\`, \`login\`, \`pass\`, \`lastname\`, \`firstname\`, \`town\`) VALUES ("$Id", "$Identifiant", "$MDP", "$Prenom", "$NOM", "$Ville");
EOF
done < <(tail -n +2 users.csv)

echo "Insertion des données terminée"
