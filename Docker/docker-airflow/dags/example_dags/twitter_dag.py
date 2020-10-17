from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.sensors.file_sensor import FileSensor
from airflow.operators.postgres_operator import PostgresOperator
from datetime import datetime
import sys
sys.path.insert(1,"/usr/local/airflow/dags/data_pipelines")
import fetching_tweets
import cleaning_tweets


default_args = {
        "start_date" : datetime(2020, 1, 1),
        "owner": "airflow"
        }

with DAG(dag_id="twitter_dag", schedule_interval="@daily", default_args=default_args, catchup=False) as dag:
    waiting_for_tweets = FileSensor(task_id="waiting_for_tweets",
                                    fs_conn_id="fs_tweet",
                                    filepath="data.csv",
                                    poke_interval=5
                                    )

    fetching_tweets = PythonOperator(task_id="fetching_tweets",
                                     python_callable=fetching_tweets.main
                                     )
    cleaning_tweets = PythonOperator(task_id="cleaning_tweets",
                                     python_callable=cleaning_tweets.main
                                     )
    
    storing_tweets = PostgresOperator(task_id='storing_tweets',
                                      postgres_conn_id="postgres_default",
                                      sql='''CREATE TABLE IF NOT EXISTS tweets(Tweet varchar(250), Date varchar(50),  Retweet_from varchar(50), T_User varchar(50));'''
                                      )

    update_tweets = PostgresOperator(task_id='update_tweets',
                                     postgres_conn_id="postgres_default",
                                     sql='''COPY tweets(Tweet, Date, Retweet_from, T_User) FROM '/tmp/data_cleaned.csv' DELIMITER ',' CSV HEADER;'''
                                      )

    waiting_for_tweets >> fetching_tweets >> cleaning_tweets >> storing_tweets >> update_tweets