FROM openjdk:11-jre-slim

# Variables d'environnement
ENV SPARK_VERSION=3.4.1
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Installation des dépendances
RUN apt-get update && \
    apt-get install -y wget procps tini python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Téléchargement et installation de Spark
RUN wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}

# Création des répertoires nécessaires
RUN mkdir -p $SPARK_HOME/logs $SPARK_HOME/spark-events

# Copie des fichiers de configuration
COPY conf/spark-defaults.conf ${SPARK_HOME}/conf/
COPY conf/log4j.properties ${SPARK_HOME}/conf/
COPY conf/spark-env.sh ${SPARK_HOME}/conf/
RUN chmod +x ${SPARK_HOME}/conf/spark-env.sh

# Copie du script de démarrage
COPY scripts/start-spark.sh ${SPARK_HOME}/
RUN chmod +x ${SPARK_HOME}/start-spark.sh

# Définition du répertoire de travail
WORKDIR ${SPARK_HOME}

# Exposition des ports
EXPOSE 8080 7077 6066 8081

# Utilisation de tini comme point d'entrée
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["./start-spark.sh"]