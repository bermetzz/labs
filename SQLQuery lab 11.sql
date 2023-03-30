--declare @a int = 10, @b int = 15, @c  int =0
--Если @c >= 0 то вычислить сумму чисел, иначе откат транзакции   

BEGIN TRANSACTION
DECLARE @a int, @b int, @c int;
SET @a = 10;
SET @b = 15;
SET @c = 0;
IF @c >= 0
BEGIN
  DECLARE @sum int = @a + @b + @c
  PRINT 'The sum: ' + CAST(@sum AS VARCHAR)
END
ELSE
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END

COMMIT TRANSACTION

--Вставить данные в таблицу клиентов, если не заполнена фамилия клиента – откат транзакции

BEGIN TRANSACTION

DECLARE @lastName NVARCHAR(50) = 'Jecky'
DECLARE @firstName NVARCHAR(50) = 'Chan'
DECLARE @otch NVARCHAR(50) = 'k'  
DECLARE @passp NVARCHAR(50) = '2232' 
DECLARE @trud NVARCHAR(50) = 'yes'
DECLARE @children INT = 2
DECLARE @resume_num INT = 23
DECLARE @birthday SMALLDATETIME = 2003/12/09
DECLARE @med NVARCHAR(50) = 'yes'
DECLARE @sudimost NVARCHAR(50) = 'no'
DECLARE @id_pol INT = 2
DECLARE @id_sem INT = 1
DECLARE @id_graj INT = 2
DECLARE @id_nat INT = 3
DECLARE @id_opl INT = 3
DECLARE @id_dolj INT = 1
DECLARE @oklad NVARCHAR(50) = '3300'
IF LEN(@lastName) > 0
BEGIN
  INSERT INTO sotrudnik (imya, fam, otch, passp, nalichie_trud_knigi, kol_vo_detey, resume_nom, den_rojd, med_kn, sudimost, id_pol, id_sem_polejenie, id_grajdanstvo,id_nationality, id_tip_oplaty, id_doljnost, oklad)
  VALUES (@firstName, @lastName, @otch, @passp,@trud, @children, @resume_num, @birthday,@med, @sudimost, @id_pol, @id_sem, @id_graj, @id_nat, @id_opl, @id_dolj, @oklad )
  SELECT SCOPE_IDENTITY() AS id_sotrudnik
END
ELSE
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END

COMMIT TRANSACTION

--Вставить данные в таблицу заказов, если есть задолженность по предыдущим заказам, откатить транзакцию 

BEGIN TRANSACTION

DECLARE @id_pr INT = 4 
DECLARE @cena DECIMAL(10, 2) = 100.00 
DECLARE @comm NVARCHAR(50) = 'h'
DECLARE @id_tov INT = 2

IF EXISTS (
  SELECT 1 FROM price_list WHERE id_price_list = @id_pr AND cena > 0
)
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END
ELSE
BEGIN
  
  INSERT INTO price_list(id_price_list, dataa, cena, comments, id_tovar)
  VALUES (@id_pr, GETDATE(), @cena, @comm, @id_tov)

  SELECT SCOPE_IDENTITY() AS NewOrderId 
END

COMMIT TRANSACTION

--Выполнить индивидуальное задание по транзакциям

BEGIN TRANSACTION;

UPDATE pol
SET pol = 'Female'
WHERE id_pol = 1;

COMMIT TRANSACTION;
