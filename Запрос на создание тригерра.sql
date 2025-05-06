-- ������� ��� �������� ����� ���������� ������
CREATE TRIGGER �����������������������
ON ������
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(��������)
    BEGIN
        -- ���������, ��� ��� ������ � ������ ���������
        IF EXISTS (
            SELECT 1 
            FROM inserted i
            JOIN ������������ zu ON i.ID_������ = zu.ID_������
            WHERE i.�������� = 1 AND zu.������������ <> '���������'
        )
        BEGIN
            RAISERROR('���������� ������������ �����, �� ��� ������ ���������', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            -- ��������� ������
            UPDATE ������
            SET 
                �������� = i.��������,
                ������������� = CASE WHEN i.�������� = 1 THEN GETDATE() ELSE NULL END
            FROM inserted i
            WHERE ������.ID_������ = i.ID_������
        END
    END
    ELSE
    BEGIN
        -- ��������� ������ ���� ��� ��������
        UPDATE ������
        SET 
            ������������ = i.������������,
            ��������������� = i.���������������
        FROM inserted i
        WHERE ������.ID_������ = i.ID_������
    END
END;
GO