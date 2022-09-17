-- 检索单个列
SELECT prod_name FROM Products;
-- 检索多个列
SELECT prod_id,prod_name,prod_price FROM Products;
-- 检索所有列
SELECT * FROM Products;
-- 检索不同的值
-- 注意和 SELECT vend_id FROM Products 的不同;
-- DISTINCT具有唯一性,返回的vend_id会有唯一值
SELECT DISTINCT vend_id FROM Products;
-- 限制结果,取前5个值 
SELECT prod_name FROM Products LIMIT 5
-- 限制结果,取后面5个值
SELECT prod_name FROM Products LIMIT 5 FROM 5
-- 排序
SELECT prod_name FROM Products ORDER BY prod_name
-- 多个排序 
SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price,prod_name
-- 降序
SELECT prod_id,prod_price,prod_name FROM Products ORDER BY prod_price DESC;
-- 过滤数据 
SELECT prod_name,prod_price FROM Products WHERE prod_price = 3.48
SELECT prod_name,prod_price FROM Products WHERE prod_price BETWEEN 5 AND 10;
SELECT prod_name FROM Products WHERE prod_price IS NULL;
SELECT prod_id,prod_price,prod_name FROM Products WHERE vend_id = 'DLL01' AND prod_price <=4;
SELECT prod_id,prod_price,prod_name FROM Products WHERE vend_id = 'DLL01' OR prod_price <=

-- 创建计算字段 
-- 存储在表中的数据都不是应用程序所需要的.我们需要直接从数据库中检索出转换,计算或格式化过后数据.而不是检索出数据,然后再在客户端应用程序中重新格式化.
-- 计算字段是运行时在SELECT语句内创建的,并不实际存在于数据库中.
SELECT Concat(vend_name, '(',vend_country,')') FROM Vendors ORDER BY vend_name
-- alias别名
SELECT Concat(RTrim(vend_name),'(',RTrim(vend_country),')') AS vend_title FROM Vendors ORDER BY vend_name
-- 算术运算
SELECT prod_id,quantity,item_price,quantity*item_price AS expanded_price FROM OrderItems WHERE order_num = 20008

-- 使用函数处理数据 
SELECT vend_name ,UPPER(vend_name) AS vend_name_upcase FROM Vendors ORDER BY vend_name

-- 汇总数据
-- 我们经常需要汇总数据而用把它们实际检索出来(不浪费时间和处理资源)
-- 返回Products表中掺产品的平均价格
SELECT AVG(prod_price) AS avg_price FROM Products 
-- COUNT(*)对表中行的数目进行计算,不论是否为NULL值,COUNT(column)对特定列中的值进行计算 
SELECT COUNT(*) AS num_cust FROM Customers -- 返回Customers表中顾客的总数 
SELECT COUNT(cust_email) AS num_cust FROM Customers -- 对具有电子邮件地址的客户计数
-- 返回Products表中最贵/便宜物品的价格 
SELECT MAX(prod_price) AS max_price FROM Products
SELECT MIN(prod_price) as min_price FROM Products
-- 求和
SELECT SUM(quantity) AS items_ordered FROM OrderItems WHERE order_num = 20005
SELECT SUM(item_price*quantity) AS total_price FROM OrderItems WHERE order_num = 20006
-- 聚焦不同值,默认为ALL,DISTINCT参数
SELECT AVG(DISTINCT prod_price) AS avg_price FROM Products WHERE vend_id = 'DLL01' -- 平均值只考虑各个不同的价格
-- 组合聚焦函数使用
SELECT COUNT(*) AS num_items, MIN(prod_price) AS price_min,MAX(prod_price) AS price_max,AVG(prod_price) AS price_avg FROM Products

-- 分组GROUP BY,过滤分组HAVING
-- 假设表中vend_id有供应商brs01(3个),供应商dll01(4个),fng01(2个)
SELECT vend_id,COUNT(*) AS num_prods FROM Products GROUP BY vend_id;
-- vend_id   num_prods 
--  brs01     3 
--  dll01     4
--  fng01     2
SELECT cust_id,COUNT(*) AS orders FROM Orders GROUP BY cust_id HAVING COUNT(*) >= 2