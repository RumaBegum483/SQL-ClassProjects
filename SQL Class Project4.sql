-- CREATING A TRIGGER ON TABLE PRODUCT TO UPDATE P_ORDER FIELD WHEN P_QOH FALLS BELOW P_MIN

IF EXISTS ( SELECT NAME FROM SYSOBJECTS
WHERE NAME= 'TRG_PRODUCT_REORDER' AND TYPE='TR')
DROP TRIGGER TRG_PRODUCT_REORDER
GO
CREATE TRIGGER TRG_PRODUCT_REORDER ON PRODUCT
AFTER INSERT, UPDATE AS
BEGIN
	UPDATE PRODUCT	
		SET P_REORDER=1
			WHERE P_QOH <= P_MIN;

END;

--2

SELECT * FROM PRODUCT;

BEGIN TRANSACTION
		UPDATE PRODUCT
		SET P_QOH = 4
		WHERE P_CODE= '2232/QWE';

		SELECT *FROM PRODUCT;
		ROLLBACK;
		SELECT * FROM PRODUCT;

--3

IF EXISTS (SELECT NAME FROM SYSOBJECTS
	WHERE NAME= 'TRG_PRODUCT_REORDER' AND TYPE = 'TR')
		DROP TRIGGER TRG_PRODUCT_REORDER;

GO
CREATE TRIGGER TRG_PRODUCT_REORDER ON PRODUCT
AFTER INSERT,UPDATE AS
BEGIN
	UPDATE PRODUCT SEt P_REORDER= 1
		WHERE P_QOH <= P_MIN;
	UPDATE PRODUCT SET P_REORDER =0
		WHERE P_QOH> P_MIN;
END;

--4

BEGIN TRANSACTION
	
		UPDATE PRODUCT
		SET P_MIN=10
		WHERE P_CODE = '2232/QWE';

		SELECT * FROM PRODUCT;
		ROLLBACK;
		SELECT * FROM PRODUCT;
		 
CREATE PROCEDURE PRC_PROD_DISCOUNT
AS
BEGIN
	UPDATE PRODUCT 
		SET P_DISCOUNT = P_DISCOUNT + .05
		WHERE P_QOH >=P-MIN *2;

--5

BEGIN TRANSACTION
	EXEC PRC_PROD_DISCOUNT
SELECT * FROM PRODUCT
ROLLBACK;
SELECT * FROM PRODUCT;