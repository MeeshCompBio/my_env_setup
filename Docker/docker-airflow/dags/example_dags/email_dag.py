from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.email_operator import EmailOperator

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2018, 1, 30),
    'email': ['person@email.com'],
    'email_on_failure': True,
    'retries': 2
}

with DAG('email_failure_dag',
          default_args=default_args,
          schedule_interval='@daily',
          catchup=False) as dag:
    task_that_always_fails = BashOperator(
            task_id='task_that_always_fails',
            bash_command='exit 1',
            dag=dag,
        )
    # email = EmailOperator(
    #     task_id='send_email',
    #     to='person@email.com',
    #     subject='Airflow Alert',
    #     html_content=""" <h3>Email Test</h3> """,
    #     dag=dag,
    #     catchup=False
    #     )