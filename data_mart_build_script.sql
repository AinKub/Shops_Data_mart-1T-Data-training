WITH report_dates (first_day_of_the_month, last_day_of_the_month) AS (
	VALUES ('2023-07-01'::DATE, '2023-07-31'::DATE)   -- change this dates if you want to get 
                                                      -- data mart for another month
)
SELECT
	sps.shop_name,
	prs.product_name,
	fts.sales_cnt AS sales_fact,
	pl.plan_cnt AS sales_plan,
	ROUND(CAST((fts.sales_cnt / pl.plan_cnt::FLOAT) AS DECIMAL), 2) AS sales_ratio,
	fts.sales_cnt * prs.price AS income_fact,
	pl.plan_cnt * prs.price AS income_plan,
	ROUND(CAST((fts.sales_cnt * prs.price) / (pl.plan_cnt * prs.price) AS DECIMAL), 2) AS income_ratio
FROM 
    report_dates rd,
	shops sps
	JOIN plan pl ON sps.shop_id = pl.shop_id
	JOIN products prs ON pl.product_id = prs.product_id,
	(
        WITH report_dates (first_day_of_the_month, last_day_of_the_month) AS (
            VALUES ('2023-07-01'::DATE, '2023-07-31'::DATE)   -- change this dates if you want to get 
                                                              -- data mart for another month
        )
        SELECT
			'dns' AS shop_name,
			sd.product_id,
			SUM(sd.sales_cnt) AS sales_cnt
		FROM shop_dns sd, report_dates rd
        WHERE sd."date" >= rd.first_day_of_the_month AND 
			  sd."date" <= rd.last_day_of_the_month
		GROUP BY sd.product_id
		UNION
		SELECT
			'mvideo' AS shop_name,
			sm.product_id,
			SUM(sm.sales_cnt) AS sales_cnt
		FROM shop_mvideo sm, report_dates rd
        WHERE sm."date" >= rd.first_day_of_the_month AND 
			  sm."date" <= rd.last_day_of_the_month
		GROUP BY sm.product_id
		UNION
		SELECT
			'sitilink' AS shop_name,
			ss.product_id,
			SUM(ss.sales_cnt) AS sales_cnt
		FROM shop_sitilink ss, report_dates rd
        WHERE ss."date" >= rd.first_day_of_the_month AND 
			  ss."date" <= rd.last_day_of_the_month
		GROUP BY ss.product_id 
		) AS fts				-- fact sales 
WHERE
	sps.shop_name = fts.shop_name AND 
	prs.product_id = fts.product_id AND
	pl.plan_date >= rd.first_day_of_the_month AND 
	pl.plan_date <= rd.last_day_of_the_month