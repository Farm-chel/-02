CREATE TABLE ������� (
    ID_������� INT PRIMARY KEY IDENTITY(1,1),
    ������� NVARCHAR(50) NOT NULL,
    ��� NVARCHAR(50) NOT NULL,
    �������� NVARCHAR(50),
    ������� NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    ����� NVARCHAR(200),
    ����_����������� DATE DEFAULT GETDATE()
);

-- ������� "����������"
CREATE TABLE ���������� (
    ID_���������� INT PRIMARY KEY IDENTITY(1,1),
    ID_������� INT NOT NULL,
    ����� NVARCHAR(50) NOT NULL,
    ������ NVARCHAR(50) NOT NULL,
    ���_������� INT,
    VIN_����� NVARCHAR(17),
    ��������_���� NVARCHAR(15),
    ������ INT,
    FOREIGN KEY (ID_�������) REFERENCES �������(ID_�������)
);

-- ������� "������"
CREATE TABLE ������ (
    ID_������ INT PRIMARY KEY IDENTITY(1,1),
    ������������ NVARCHAR(100) NOT NULL,
    �������� NVARCHAR(500),
    ��������� DECIMAL(10,2) NOT NULL,
    ������������_���������� INT  -- � �������
);

-- ������� "��������"
CREATE TABLE �������� (
    ID_�������� INT PRIMARY KEY IDENTITY(1,1),
    ������������ NVARCHAR(100) NOT NULL,
    �������� NVARCHAR(500),
    ������� NVARCHAR(50),
    ������������� NVARCHAR(100),
    ���� DECIMAL(10,2) NOT NULL,
    ����������_��_������ INT DEFAULT 0
);

-- ������� "����������"
CREATE TABLE ���������� (
    ID_���������� INT PRIMARY KEY IDENTITY(1,1),
    ������� NVARCHAR(50) NOT NULL,
    ��� NVARCHAR(50) NOT NULL,
    �������� NVARCHAR(50),
    ��������� NVARCHAR(100) NOT NULL,
    ������� NVARCHAR(20),
    Email NVARCHAR(100),
    ����_������ DATE NOT NULL,
    �������� DECIMAL(10,2)
);

-- ������� "������"
CREATE TABLE ������ (
    ID_������ INT PRIMARY KEY IDENTITY(1,1),
    ID_���������� INT NOT NULL,
    ID_���������� INT NOT NULL,
    ����_�������� DATETIME DEFAULT GETDATE(),
    ����_������_����� DATETIME,
    ����_���������_����� DATETIME,
    ������ NVARCHAR(50) DEFAULT '�����',
    ��������_�������� NVARCHAR(1000),
    �����_��������� DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (ID_����������) REFERENCES ����������(ID_����������),
    FOREIGN KEY (ID_����������) REFERENCES ����������(ID_����������)
);

-- ������� "������_������_������" (����� ������-��-������ ����� ������ � ������)
CREATE TABLE ������_������_������ (
    ID_������ INT NOT NULL,
    ID_������ INT NOT NULL,
    ���������� INT DEFAULT 1,
    ���������_��_������_���������� DECIMAL(10,2),
    PRIMARY KEY (ID_������, ID_������),
    FOREIGN KEY (ID_������) REFERENCES ������(ID_������),
    FOREIGN KEY (ID_������) REFERENCES ������(ID_������)
);

-- ������� "������_������_��������" (����� ������-��-������ ����� ������ � ��������)
CREATE TABLE ������_������_�������� (
    ID_������ INT NOT NULL,
    ID_�������� INT NOT NULL,
    ���������� INT DEFAULT 1,
    ����_��_������_������� DECIMAL(10,2),
    PRIMARY KEY (ID_������, ID_��������),
    FOREIGN KEY (ID_������) REFERENCES ������(ID_������),
    FOREIGN KEY (ID_��������) REFERENCES ��������(ID_��������)
);

-- ������� "������_������"
CREATE TABLE ������_������ (
    ID_������ INT PRIMARY KEY IDENTITY(1,1),
    ID_���������� INT NOT NULL,
    ���� DATE NOT NULL,
    �����_������ TIME NOT NULL,
    �����_��������� TIME NOT NULL,
    FOREIGN KEY (ID_����������) REFERENCES ����������(ID_����������)
);