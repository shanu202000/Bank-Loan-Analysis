#DATA
SELECT * FROM bank_loan_data;
# KPI Query start
# 1) Total  no application 
SELECT COUNT(DISTINCT id) AS Total_loan_application FROM bank_loan_data;
# 2) Month-to-Date (MTD) Loan Applications 
SELECT COUNT(id) AS MTD_total_Loan_application FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12;
# 3) previous Month-to-Date (PMTD) Loan Applications 
SELECT COUNT(id) AS PMTD_total_Loan_application FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11;
# 4) 	Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_amount FROM bank_loan_data;
# 5) MTD Total Funded Amount 
SELECT SUM(loan_amount) AS MTD_Total_Funded_amount FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12;
# 6) PMTD Total Funded Amount 
SELECT SUM(loan_amount) AS PMTD_Total_Funded_amount FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11;
# 7) Total Amount Received
SELECT SUM(total_payment) AS Total_Recived_amount FROM bank_loan_data;
# 8) MTD Total Amount Received
SELECT SUM(total_payment) AS MTDTotal_Recived_amount FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12;
# 9) PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTDTotal_Recived_amount FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11;
# 10) Average Interest Rate
SELECT CAST(AVG(int_rate) *100 AS DECIMAL(10,2)) AS Avg_intrst_rate  FROM bank_loan_data;
# 11) MTD Average Interest Rate
SELECT CAST(AVG(int_rate) *100 AS DECIMAL(10,2)) AS MTD_Avg_intrst_rate  FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12;
# 12) PMTD Average Interest Rate
SELECT CAST(AVG(int_rate) *100 AS DECIMAL(10,2)) AS PMTD_Avg_intrst_rate  FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11;
# 13)Average Debt-to-Income Ratio (DTI): 
SELECT CAST(AVG(dti) *100 AS DECIMAL(10,2)) AS Avg_dti FROM bank_loan_data;
# 14) MTD Average Debt-to-Income Ratio (DTI): 
SELECT CAST(AVG(dti) *100 AS DECIMAL(10,2)) AS MTD_Avg_dti FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12;
# 15) PMTD Average Debt-to-Income Ratio (DTI): 
SELECT CAST(AVG(dti) *100 AS DECIMAL(10,2)) AS PMTD_Avg_dti FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11;
#KPI DASHBOARD(1) ENDS HERE

# Good Loan v Bad Loan KPI’s Query
# 16) Good Loan Application Percentage:  
SELECT (COUNT(CASE WHEN loan_status='Fully paid' OR loan_status='Current' THEN id END) *100)/COUNT(DISTINCT id)
AS Percentage_Good_loan
FROM bank_loan_data;
# 17) Good Loan Application
SELECT COUNT(CASE WHEN loan_status='Fully paid' OR loan_status='Current' THEN id END)
AS Good_Loan_totl_application
FROM bank_loan_data;
# 18) Good Loan Funded Amount: 
SELECT SUM(CASE WHEN loan_status='Fully paid' OR loan_status='Current' THEN loan_amount END)
AS Good_loan_amount
FROM bank_loan_data;
# 19) Good Loan Total Received Amount: 
SELECT SUM(CASE WHEN loan_status='Fully paid' OR loan_status='Current' THEN total_payment END)
AS Good_loan_payment_amount
FROM bank_loan_data;
# 20) Bad Loan Application Percentage
SELECT (COUNT(CASE WHEN loan_status='Charged Off'  THEN id END) *100)/COUNT(DISTINCT id)
AS Percentage_Bad_loan
FROM bank_loan_data;
# 21) Bad Loan Application
SELECT COUNT(CASE WHEN loan_status='Charged Off'  THEN id END) *100
AS Bad_loan_application
FROM bank_loan_data;
# 22) Bad Loan total Funded Amount
SELECT SUM(CASE WHEN loan_status='Charged Off'  THEN loan_amount END)
AS Bad_loan_amount
FROM bank_loan_data;
# 23) Bad Loan Recived Amount
SELECT SUM(CASE WHEN loan_status='Charged Off'  THEN total_payment END)
AS Bad_loan_payment_amount
FROM bank_loan_data;
# 24) A grid view report categorized by 'Loan Status'. 
SELECT loan_status,
COUNT(DISTINCT id) AS Total_application,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_recived_amount,
AVG(int_rate) AS Avg_inrst_rate,
AVG(dti) AS Avg_dti
FROM bank_loan_data
GROUP BY loan_status;
# 25) A grid view report(MTD) categorized by 'Loan Status.' 
SELECT loan_status,
SUM(loan_amount) AS MTD_Total_Funded_amount,
SUM(total_payment) AS MTD_Total_received_amount
FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=12
GROUP BY loan_status;
# 26) A grid view report(PMTD) categorized by 'Loan Status.' 
SELECT loan_status,
SUM(loan_amount) AS PMTD_Total_Funded_amount,
SUM(total_payment) AS PMTD_Total_received_amount
FROM bank_loan_data
WHERE MONTH(str_to_date(issue_date,'%d-%m-%y'))=11
GROUP BY loan_status;


#CHART_DASHBOARD_QUERY_START_HERE
# Monthly Trends by Issue Date 
SELECT MONTHNAME(str_to_date(issue_date,'%d-%m-%y')) AS Month_name,
MONTH(str_to_date(issue_date,'%d-%m-%y')) AS MONTH_NO,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY MONTHNAME(str_to_date(issue_date,'%d-%m-%y')),MONTH(str_to_date(issue_date,'%d-%m-%y'))
ORDER BY MONTH(str_to_date(issue_date,'%d-%m-%y'));
SELECT address_state,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;
SELECT term,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;
SELECT emp_length,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;
SELECT purpose,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;
SELECT home_ownership,
COUNT(id) AS Total_loan_application,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_recived_amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id)  DESC;
