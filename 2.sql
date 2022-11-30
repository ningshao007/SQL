-- 组合查询
SELECT cust_name,cust_contact,cust_email FROM Customers WHERE cust_state IN ('AAA','BBB','CCC')
UNION ALL SELECT cust_name,cust_contact,cust_email
FROM Customers WHERE cust_name = 'dddd';