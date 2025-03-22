from pyspark.sql import SparkSession

# Initialisation de la session Spark
spark = SparkSession.builder \
    .appName("TestSparkCluster") \
    .master("spark://spark-master:7077") \
    .getOrCreate()

# Afficher la version de Spark
print(f"Version de Spark : {spark.version}")

# Création d'un DataFrame
data = [("Java", 20000), ("Python", 25000), ("Scala", 15000)]
columns = ["language", "Users"]
df = spark.createDataFrame(data, columns)

# Vérification du nombre de partitions
num_partitions = df.rdd.getNumPartitions()
print(f"Nombre de partitions : {num_partitions}")

# Afficher le DataFrame
print("Données du DataFrame :")
df.show()

# Operations
print("Schéma du DataFrame :")
df.printSchema()

# Calcul de la somme des utilisateurs
total_users = df.agg({"Users": "sum"}).collect()[0][0]
print(f"Nombre total d'utilisateurs: {total_users}")

# Afficher les langages ayant plus de 20000 utilisateurs
print("Langages avec plus de 20000 utilisateurs :")
df.filter(df.Users > 20000).show()

# Fermer la session
spark.stop()