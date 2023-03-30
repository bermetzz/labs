-- Написать триггеры (before, after, instead of DML) для любой таблицы в базе данных и проверить эффекты работы

--CREATE TRIGGER instead_of_update_employee
--ON student
--INSTEAD OF UPDATE
--AS
--BEGIN
--UPDATE student 
--SET parol = CASE WHEN inserted.parol < 2 THEN 2 ELSE inserted.parol END
--FROM inserted
--END;

--CREATE TRIGGER after_update_stu
--ON pol
--AFTER UPDATE
--AS
--BEGIN
-- Âñòàâëÿåì èçìåíåííûå äàííûå â òàáëèöó ëîãà.
--INSERT INTO pol(id_pol, pol)
--SELECT deleted.id_pol, deleted.pol
--FROM deleted JOIN inserted ON deleted.id_pol = inserted.id_pol;
--END;

CREATE TRIGGER trg_nationality_insert
ON natsionalnost
INSTEAD OF INSERT
AS
BEGIN
  IF EXISTS (SELECT * FROM inserted WHERE natsionalnost = '')
  BEGIN
    RAISERROR ('Insertion of a nationality with an empty value is not allowed.', 16, 1)
    ROLLBACK TRANSACTION
  END
END;
GO
