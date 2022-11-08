WITH total_tweets AS (
  SELECT 
    user_id, 
    COUNT(tweet_id) AS tweets_num 
  FROM tweets 
  WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31' 
  GROUP BY user_id) 
  
SELECT 
  tweets_num AS tweet_bucket, 
  COUNT(user_id) AS users_num 
FROM total_tweets 
GROUP BY tweets_num;
