select * from customer_churn

alter table customer_churn
drop column NumberofDependents,
drop column ZipCode,
drop column offer,
drop column MultipleLines,
drop column InternetService,
drop column OnlineSecurity,
drop column OnlineBackup,
drop column DeviceProtectionPlan,
drop column premiumtechsupport,
drop column streamingtv,
drop column streamingmovies,
drop column streamingmusic,
drop column unlimiteddata,
drop column paperlessbilling;

delete from customer_churn
where AvgMonthlyLongDistanceCharges is null
delete from customer_churn
where internettype is null

select count(customerID)
from customer_churn;

set sql_safe_updates=0

ALTER TABLE customer_churn ADD churn_flag INT;
UPDATE customer_churn
SET churn_flag = CASE 
    WHEN customerstatus = 'Churned' THEN 1
    WHEN customerstatus = 'Stayed' THEN 0
    when customerstatus= 'joined' then 0
    ELSE NULL  -- Handle any unexpected or missing statuses
END;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN CustomerStatus = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    AVG(CASE WHEN CustomerStatus = 'Churned' THEN 1.0 ELSE 0.0 END) AS churn_rate
FROM
    customer_churn;
    
    SELECT
    contract,
    AVG(monthlycharge) AS avg_monthly_charges
FROM
    customer_churn
WHERE
   CustomerStatus = 'Churned'
GROUP BY
    contract;