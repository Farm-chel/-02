-- ������� ��������� ��������
CREATE TABLE ����������������� (
    ID_���������_�������� INT IDENTITY(1,1) PRIMARY KEY,
    �������� NVARCHAR(100) NOT NULL,
    ����� NVARCHAR(200) NOT NULL,
    ��� NVARCHAR(12) NOT NULL UNIQUE,
    ������������� NVARCHAR(20) NOT NULL,
    ��� NVARCHAR(9) NOT NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� ����� ��������� �������
CREATE TABLE �������������������� (
    ID_����_������ INT IDENTITY(1,1) PRIMARY KEY,
    �������� NVARCHAR(50) NOT NULL,
    �������� NVARCHAR(200) NULL
);

-- ������� ���������
CREATE TABLE �������� (
    ID_�������� INT IDENTITY(1,1) PRIMARY KEY,
    ����� NVARCHAR(50) NOT NULL UNIQUE,
    ������ NVARCHAR(100) NOT NULL,
    ��� NVARCHAR(100) NOT NULL,
    ������������ DATE NOT NULL,
    ������������� NVARCHAR(4) NOT NULL,
    ������������� NVARCHAR(6) NOT NULL,
    ������� NVARCHAR(15) NOT NULL,
    Email NVARCHAR(100) NULL,
    ���������������������� NVARCHAR(20) NOT NULL,
    ID_����_������ INT NOT NULL,
    ID_���������_�������� INT NOT NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL,
    CONSTRAINT UQ_������� UNIQUE (�������������, �������������),
    CONSTRAINT FK_��������_����������� FOREIGN KEY (ID_����_������) REFERENCES ��������������������(ID_����_������),
    CONSTRAINT FK_��������_����������������� FOREIGN KEY (ID_���������_��������) REFERENCES �����������������(ID_���������_��������)
);

-- ������� ����� �����������
CREATE TABLE ������ (
    ID_������ INT IDENTITY(1,1) PRIMARY KEY,
    ��������� NVARCHAR(20) NOT NULL UNIQUE,
    ������������ NVARCHAR(100) NOT NULL,
    ��������� DECIMAL(10, 2) NOT NULL,
    �������������� INT NOT NULL, -- � ����
    ����������������� INT NULL, -- � ����
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� �������
CREATE TABLE ������ (
    ID_������ INT IDENTITY(1,1) PRIMARY KEY,
    ID_�������� INT NOT NULL,
    ������������ DATETIME NOT NULL DEFAULT GETDATE(),
    ������������ NVARCHAR(20) NOT NULL DEFAULT '������',
    ��������������� INT NULL, -- � ����
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL,
    CONSTRAINT FK_������_�������� FOREIGN KEY (ID_��������) REFERENCES ��������(ID_��������)
);

-- ������� ����� ������� � ����� (������ �� ������)
CREATE TABLE ������������ (
    ID_������_������ INT IDENTITY(1,1) PRIMARY KEY,
    ID_������ INT NOT NULL,
    ID_������ INT NOT NULL,
    ������������ NVARCHAR(20) NOT NULL DEFAULT '���������',
    CONSTRAINT FK_������������_������ FOREIGN KEY (ID_������) REFERENCES ������(ID_������),
    CONSTRAINT FK_������������_������ FOREIGN KEY (ID_������) REFERENCES ������(ID_������)
);

-- ������� ������������
CREATE TABLE ����������� (
    ID_����������� INT IDENTITY(1,1) PRIMARY KEY,
    ������������ NVARCHAR(100) NOT NULL,
    ������ NVARCHAR(50) NOT NULL,
    ������������� NVARCHAR(50) NOT NULL UNIQUE,
    �������������������������� DATE NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� ����������
CREATE TABLE ��������� (
    ID_��������� INT IDENTITY(1,1) PRIMARY KEY,
    ����� NVARCHAR(50) NOT NULL UNIQUE,
    ������ NVARCHAR(100) NOT NULL,
    ��� NVARCHAR(100) NOT NULL,
    ������������������ DATETIME NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� ����� ���������� � ����� (������ �� ������)
CREATE TABLE ��������������� (
    ID_���������_������ INT IDENTITY(1,1) PRIMARY KEY,
    ID_��������� INT NOT NULL,
    ID_������ INT NOT NULL,
    CONSTRAINT FK_���������������_��������� FOREIGN KEY (ID_���������) REFERENCES ���������(ID_���������),
    CONSTRAINT FK_���������������_������ FOREIGN KEY (ID_������) REFERENCES ������(ID_������)
);

-- ������� �����������
CREATE TABLE ���������� (
    ID_���������� INT IDENTITY(1,1) PRIMARY KEY,
    ����� NVARCHAR(50) NOT NULL UNIQUE,
    ������ NVARCHAR(100) NOT NULL,
    ��� NVARCHAR(100) NOT NULL,
    ������������������ DATETIME NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� ���������������
CREATE TABLE �������������� (
    ID_�������������� INT IDENTITY(1,1) PRIMARY KEY,
    ����� NVARCHAR(50) NOT NULL UNIQUE,
    ������ NVARCHAR(100) NOT NULL,
    ������������������ DATETIME NULL,
    �������� BIT DEFAULT 0 NOT NULL,
    ������������� DATETIME NULL
);

-- ������� ��������� �����
CREATE TABLE ��������������� (
    ID_���������_������ INT IDENTITY(1,1) PRIMARY KEY,
    ID_������_������ INT NOT NULL,
    ID_��������� INT NOT NULL,
    ID_����������� INT NOT NULL,
    ������������������� DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_���������������_������������ FOREIGN KEY (ID_������_������) REFERENCES ������������(ID_������_������),
    CONSTRAINT FK_���������������_��������� FOREIGN KEY (ID_���������) REFERENCES ���������(ID_���������),
    CONSTRAINT FK_���������������_����������� FOREIGN KEY (ID_�����������) REFERENCES �����������(ID_�����������)
);

-- ������� ������ � ������ �����������
CREATE TABLE ����������������� (
    ID_������ INT IDENTITY(1,1) PRIMARY KEY,
    ID_����������� INT NOT NULL,
    ID_������_������ INT NOT NULL,
    �������������������� DATETIME NOT NULL,
    ������������������� DATETIME NULL,
    ���������������������� INT NULL, -- � ��������
    CONSTRAINT FK_�����������������_����������� FOREIGN KEY (ID_�����������) REFERENCES �����������(ID_�����������),
    CONSTRAINT FK_�����������������_������������ FOREIGN KEY (ID_������_������) REFERENCES ������������(ID_������_������)
);

-- ������� ������� �����
CREATE TABLE ������������ (
    ID_������ INT IDENTITY(1,1) PRIMARY KEY,
    ����������������� NVARCHAR(50) NOT NULL,
    ���������������� DATETIME NOT NULL DEFAULT GETDATE(),
    �������� BIT NOT NULL,
    IP����� NVARCHAR(15) NULL,
    UserAgent NVARCHAR(200) NULL
);

-- ������� ������ ��������� ���������
CREATE TABLE ����������������������� (
    ID_����� INT IDENTITY(1,1) PRIMARY KEY,
    ID_���������� INT NOT NULL,
    ID_���������_�������� INT NOT NULL,
    ���������� NVARCHAR(20) NOT NULL,
    ������������ DATETIME NOT NULL DEFAULT GETDATE(),
    ����� DECIMAL(12, 2) NOT NULL,
    ������ NVARCHAR(20) NOT NULL DEFAULT '������',
    CONSTRAINT FK_�����_���������� FOREIGN KEY (ID_����������) REFERENCES ����������(ID_����������),
    CONSTRAINT FK_�����_����������������� FOREIGN KEY (ID_���������_��������) REFERENCES �����������������(ID_���������_��������)
);

-- ������� ����� ������ � �������
CREATE TABLE ����������� (
    ID_����� INT IDENTITY(1,1) PRIMARY KEY,
    ID_����� INT NOT NULL,
    ID_������ INT NOT NULL,
    CONSTRAINT FK_�����������_����� FOREIGN KEY (ID_�����) REFERENCES �����������������������(ID_�����),
    CONSTRAINT FK_�����������_������ FOREIGN KEY (ID_������) REFERENCES ������(ID_������)
);
-- ���������� �������� ������ ��� ����� ��������� �������
INSERT INTO �������������������� (��������, ��������)
VALUES 
('���', '������������ ����������� �����������'),
('���', '������������ ����������� �����������'),
('���', '����������� ���������� �� �����');
GO

-- �������� ������������� ��� ��������� �������� �������
CREATE VIEW �������������� AS
SELECT 
    �.ID_������,
    �.��� AS �������,
    �.������������,
    �.������������,
    COUNT(��.ID_������) AS ���������������,
    SUM(�.���������) AS ��������������
FROM ������ �
JOIN �������� � ON �.ID_�������� = �.ID_��������
JOIN ������������ �� ON �.ID_������ = ��.ID_������
JOIN ������ � ON ��.ID_������ = �.ID_������
WHERE �.�������� = 0
GROUP BY �.ID_������, �.���, �.������������, �.������������;
GO

-- �������� ������������� ��� ������� �����
CREATE VIEW �������������������� AS
SELECT 
    �.����������������,
    �.�����������������,
    CASE 
        WHEN �.ID_�������������� IS NOT NULL THEN '�������������'
        WHEN �.ID_���������� IS NOT NULL THEN '���������'
        WHEN �.ID_��������� IS NOT NULL THEN '��������'
        WHEN �.ID_�������� IS NOT NULL THEN '�������'
        ELSE '�����������'
    END AS ����,
    CASE WHEN �.�������� = 1 THEN '�������' ELSE '������' END AS ���������,
    �.IP�����,
    �.UserAgent
FROM ������������ �
LEFT JOIN �������������� � ON �.����������������� = �.�����
LEFT JOIN ���������� � ON �.����������������� = �.�����
LEFT JOIN ��������� � ON �.����������������� = �.�����
LEFT JOIN �������� � ON �.����������������� = �.�����;
GO
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