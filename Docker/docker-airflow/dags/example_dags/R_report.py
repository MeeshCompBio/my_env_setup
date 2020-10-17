from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.sensors.file_sensor import FileSensor
from airflow.operators.email_operator import EmailOperator
from datetime import datetime
import sys
sys.path.insert(1,"/usr/local/airflow/dags/data_pipelines")


default_args = {
        "start_date" : datetime(2020, 1, 1),
        "owner": "airflow",
        'email': ['person@email.com'],
        'email_on_failure': True,
        }

with DAG(dag_id="R_scripts_dag", schedule_interval="@daily", catchup=False, default_args=default_args) as dag:
    say_hello = BashOperator(task_id='R_say_hello',
                             bash_command="Rscript /usr/local/airflow/dags/data_pipelines/Rhello.R"
                            )

    email = EmailOperator(
                            task_id='send_email',
                            to=['person@email.com'],
                            subject='early warning report Final',
                            html_content=""" <h3>Email Test</h3> """,
                            files=['some_file.txt'],
                            dag=dag,
                            catchup=False
    )

    say_hello >> email