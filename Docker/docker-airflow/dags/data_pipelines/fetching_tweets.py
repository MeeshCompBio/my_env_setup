import pandas as pd
from datetime import datetime as dt

LOCAL_DIR='/tmp/'

def main():
    tweets = pd.read_csv('/usr/local/airflow/dags/data/data.csv')
    
    tweets = tweets.assign(Time=pd.to_datetime(tweets.Time)).drop('row ID', axis='columns')
    
    tweets.to_csv(LOCAL_DIR + 'data_fetched.csv', index=False)
    
if __name__ == '__main__':
    main()
