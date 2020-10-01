# Docker

## Containers that I like

### Airflow
This is a great way to spin up an airflow instance for demos. You have to pass in the airflow fernet env var or else you will get errors for a connection.
Keep in mind this will only really work with the SequentialExecutor.
```bash
docker pull puckel/docker-airflow
YOUR_FERNET_KEY=$(openssl rand -base64 32)
docker run -d -e AIRFLOW__CORE__FERNET_KEY=$YOUR_FERNET_KEY -p 8888:8080 puckel/docker-airflow webserver
```
Once inside the containers home dir you you can run these commands to get airflow running
```bash
mkdir dags
airflow initdb
airflow scheduler -D
```
