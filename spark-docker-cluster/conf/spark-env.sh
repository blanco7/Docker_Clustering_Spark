#!/bin/bash
export SPARK_MASTER_HOST=spark-master
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_CORES=1
export SPARK_WORKER_MEMORY=1g
export SPARK_MASTER_WEBUI_PORT=8080
export SPARK_WORKER_WEBUI_PORT=8081
export SPARK_LOG_DIR=/opt/spark/logs
export SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out
export SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out
export SPARK_DAEMON_JAVA_OPTS="-Dx=y"