WITH tmp AS(
   SELECT card_name,
      issued_amount,
      DENSE_RANK() OVER(
         PARTITION BY card_name
         ORDER BY issue_year ASC,
            issue_month ASC
      ) as rank_
   FROM monthly_cards_issued
)
SELECT card_name,
   issued_amount
FROM tmp
WHERE rank_ = 1
ORDER BY issued_amount DESC
