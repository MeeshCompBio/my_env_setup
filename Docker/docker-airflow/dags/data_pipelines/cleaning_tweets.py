import pandas as pd
import numpy as np
import re
from datetime import datetime as dt
from datetime import date, timedelta

LOCAL_DIR='/tmp/'

def main():
    tweets= pd.read_csv(LOCAL_DIR + 'data_fetched.csv')

    tweets.rename(columns={'Tweet':'tweet', 'Time':'dt', 'Retween from': 'retweet_from', 'User':'tweet_user'}, inplace=True)
    tweets.drop(['tweet_user'], axis=1, inplace=True)
    tweets['before_clean_len'] = [len(t) for t in tweets.tweet]
    tweets['tweet'] = tweets['tweet'].apply(lambda tweet: re.sub(r'@[A-Za-z0-9]+','',tweet))
    yesterday = date.today() - timedelta(days=1)
    dt = yesterday.strftime("%Y-%m-%d")
    tweets['dt'] = dt
    tweets.to_csv(LOCAL_DIR + 'data_cleaned.csv', index=False)

if __name__ == '__main__':
    main()