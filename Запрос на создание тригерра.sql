-- Триггер для проверки перед архивацией заказа
CREATE TRIGGER ПроверкаАрхивацииЗаказа
ON Заказы
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(Архивный)
    BEGIN
        -- Проверяем, что все услуги в заказе выполнены
        IF EXISTS (
            SELECT 1 
            FROM inserted i
            JOIN ЗаказыУслуги zu ON i.ID_заказа = zu.ID_заказа
            WHERE i.Архивный = 1 AND zu.СтатусУслуги <> 'Выполнена'
        )
        BEGIN
            RAISERROR('Невозможно архивировать заказ, не все услуги выполнены', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            -- Обновляем запись
            UPDATE Заказы
            SET 
                Архивный = i.Архивный,
                ДатаАрхивации = CASE WHEN i.Архивный = 1 THEN GETDATE() ELSE NULL END
            FROM inserted i
            WHERE Заказы.ID_заказа = i.ID_заказа
        END
    END
    ELSE
    BEGIN
        -- Обновляем другие поля без проверки
        UPDATE Заказы
        SET 
            СтатусЗаказа = i.СтатусЗаказа,
            ВремяВыполнения = i.ВремяВыполнения
        FROM inserted i
        WHERE Заказы.ID_заказа = i.ID_заказа
    END
END;
GO