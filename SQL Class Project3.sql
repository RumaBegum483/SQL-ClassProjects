
--1.Display last names, first names and invoice numbers for all customers, sorted by customer last
-- name. This query will skip customers that don’t have any invoices.

SELECT C.CUS_LNAME, C.CUS_FNAME, I.INV_NUMBER
FROM CUSTOMER C INNER JOIN INVOICE I On
 C.CUS_CODE= I.CUS_CODE
ORDER BY C.CUS_LNAME;

---2. Display employee last name and manager’s last name for all employees. Use appropriate column
---headings in your result such as “EMPLOYEE” and “MANAGER”. (Manager’s EMP_NUM is available in
---EMP_MGR column of EMP table).

SELECT E.EMP_LNAME AS EMPLOYEE, M.EMP_LNAME AS MANAGER
FROM EMPLOYEE AS E INNER JOIN EMPLOYEE AS M
ON E.EMP_MGR= M.EMP_NUM

--3. Display customer last name, invoice number and product code of products ordered sorted by
--customer last name in ascending order and invoice number in descending order.

SELECT C.CUS_LNAME, I.INV_NUMBER, L.P_CODE
FROM CUSTOMER AS C INNER JOIN INVOICE AS I ON C.CUS_CODE=I.CUS_CODE
JOIN LINE AS L ON I.INV_NUMBER= L.INV_NUMBER
ORDER BY C.CUS_LNAME, I.INV_NUMBER DESC;

--4. Display last names, first names, and employee count for all managers sorted in descending order by
--employees count. This query will list all employees who are managers. (Hint: You should join the
--Employee table to itself by using aliases and use the group by clause with two column names
--(employee last name and first name)

SELECT M.EMP_LNAME AS 'MANAGER LAST NAME', M.EMP_FNAME AS 'MANAGER FIRST NAME', COUNT (E.EMP_LNAME) AS EMPLOYEE
FROM EMPLOYEE AS E JOIN EMPLOYEE AS M
ON E.EMP_MGR= M.EMP_NUM
GROUP BY M.EMP_LNAME, M.EMP_FNAME

--5. List the customers who have ordered product bearing product code ‘23109-HB’. Display first names,
--last names of customers, invoice numbers and product codes. 

SELECT C.CUS_LNAME, C.CUS_FNAME, I.INV_NUMBER, L.P_CODE
FROM CUSTOMER AS C INNER JOIN INVOICE AS I ON C.CUS_CODE=I.CUS_CODE
JOIN LINE AS L ON I.INV_NUMBER= L.INV_NUMBER WHERE L.P_CODE= '23109-HB'
ORDER BY C.CUS_LNAME, I.INV_NUMBER DESC;

--6.Display Vendor details (V_CODE, V_NAME) and product details (P_CODE, P_DESCRIPT) and product
--quantity on hand in excess of product min quantity (give alias of 'Quantity above Minimum') for
--products where 'Quantity above Minimum' is less than 10 items. Sort result in the ascending order
--of 'Quantity above Minimum'

SELECT V.V_CODE, V.V_NAME, P.P_CODE, P.P_DESCRIPT, P.P_QOH-P.P_MIN AS 'QUANTITY ABOVE MINIMUM'
FROM VENDOR AS V INNER JOIN PRODUCT AS P ON V.V_CODE=P.V_CODE
ORDER BY 'QUANTITY ABOVE MINIMUM';

--7. For each product invoiced on 01-16-2010 display the product details (P_CODE, P_DESCRIPT), invoice
--date and the total number of items sold (give suitable column title) along with the total amount of
--sales (give suitable column title and sort the results on this field).There should be one row displayed
--per Product

SELECT P.P_CODE, P.P_DESCRIPT, I.INV_DATE, SUM (L.LINE_UNITS) AS 'TOTAL NUMBER OF ITEMS SOLD', SUM (L.LINE_UNITS*L.LINE_PRICE) AS 'TOTAL AMOUNT OF SALES'
FROM PRODUCT AS P INNER JOIN LINE AS L ON P.P_CODE=L.P_CODE
JOIN INVOICE AS I ON I.INV_NUMBER=L.INV_NUMBER
WHERE I.INV_DATE= '01-16-2010'
GROUP BY P.P_CODE, P.P_DESCRIPT, I.INV_DATE


--8. For each vendor based in Tennessee (TN) display the Vendor details (V_CODE, V_NAME, V_STATE)
--and the total number of items sold (give suitable column title) along with the total amount of sales
--(give suitable column title and sort the results on this field). There should be one row displayed per
--Vendor

SELECT V.V_CODE, V.V_NAME, P.P_CODE, V.V_STATE, SUM (L.LINE_UNITS) AS 'TOTAL NUMBER OF ITEMS SOLD', SUM (L.LINE_UNITS*L.LINE_PRICE) AS 'TOTAL AMOUNT OF SALES'
FROM PRODUCT AS P INNER JOIN LINE AS L ON P.P_CODE=L.P_CODE
JOIN VENDOR AS V ON V.V_CODE=P.V_CODE
WHERE  V.V_STATE= 'TN' 
GROUP BY V.V_CODE, V.V_NAME, P.P_CODE, V.V_STATE

--9. Who are the customers with no invoices placed. Display last name, first name, customer balance for
--these customers

SELECT CUS_LNAME, CUS_FNAME, CUS_BALANCE
FROM CUSTOMER AS C
WHERE 0 IN
		(SELECT COUNT(DISTINCT INV_NUMBER) AS 'INVOICE COUNT'
		FROM INVOICE AS I
		WHERE I.CUS_CODE=C.CUS_CODE)

--10. Display first and last name(s) of customers who have bought the product with the highest price?

SELECT CUS_LNAME, CUS_FNAME
FROM CUSTOMER 
WHERE CUS_CODE IN
           ( SELECT CUS_CODE FROM INVOICE 
		     WHERE INV_NUMBER IN
					(SELECT MAX(LINE_PRICE) FROM LINE));