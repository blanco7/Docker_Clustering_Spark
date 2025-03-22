#!/bin/bash

# Fonction pour obtenir l'adresse IP du conteneur
get_ip() {
    hostname -i
}

# Configuration du nœud spark en fonction du type
if [ "$SPARK_NODE_TYPE" == "master" ]; then
    echo "Démarrage du nœud Spark Master"
    start-master.sh -h $(get_ip)
    
    # Démarrage de l'interface d'historique
    start-history-server.sh
    
    # Maintient le conteneur en cours d'exécution
    tail -f $SPARK_HOME/logs/spark-*-org.apache.spark.deploy.master.Master-*.out
elif [ "$SPARK_NODE_TYPE" == "worker" ]; then
    echo "Démarrage du nœud Spark Worker"
    start-worker.sh spark://spark-master:7077
    
    # Maintient le conteneur en cours d'exécution
    tail -f $SPARK_HOME/logs/spark-*-org.apache.spark.deploy.worker.Worker-*.out
else
    echo "Type de nœud non reconnu : $SPARK_NODE_TYPE"
    echo "Utilisez 'master' ou 'worker'"
    exit 1
fi