-- Таблица страховых компаний
CREATE TABLE СтраховыеКомпании (
    ID_страховой_компании INT IDENTITY(1,1) PRIMARY KEY,
    Название NVARCHAR(100) NOT NULL,
    Адрес NVARCHAR(200) NOT NULL,
    ИНН NVARCHAR(12) NOT NULL UNIQUE,
    РасчетныйСчет NVARCHAR(20) NOT NULL,
    БИК NVARCHAR(9) NOT NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица типов страховых полисов
CREATE TABLE ТипыСтраховыхПолисов (
    ID_типа_полиса INT IDENTITY(1,1) PRIMARY KEY,
    Название NVARCHAR(50) NOT NULL,
    Описание NVARCHAR(200) NULL
);

-- Таблица пациентов
CREATE TABLE Пациенты (
    ID_пациента INT IDENTITY(1,1) PRIMARY KEY,
    Логин NVARCHAR(50) NOT NULL UNIQUE,
    Пароль NVARCHAR(100) NOT NULL,
    ФИО NVARCHAR(100) NOT NULL,
    ДатаРождения DATE NOT NULL,
    СерияПаспорта NVARCHAR(4) NOT NULL,
    НомерПаспорта NVARCHAR(6) NOT NULL,
    Телефон NVARCHAR(15) NOT NULL,
    Email NVARCHAR(100) NULL,
    НомерСтраховогоППолиса NVARCHAR(20) NOT NULL,
    ID_типа_полиса INT NOT NULL,
    ID_страховой_компании INT NOT NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL,
    CONSTRAINT UQ_Паспорт UNIQUE (СерияПаспорта, НомерПаспорта),
    CONSTRAINT FK_Пациенты_ТипыПолисов FOREIGN KEY (ID_типа_полиса) REFERENCES ТипыСтраховыхПолисов(ID_типа_полиса),
    CONSTRAINT FK_Пациенты_СтраховыеКомпании FOREIGN KEY (ID_страховой_компании) REFERENCES СтраховыеКомпании(ID_страховой_компании)
);

-- Таблица услуг лаборатории
CREATE TABLE Услуги (
    ID_услуги INT IDENTITY(1,1) PRIMARY KEY,
    КодУслуги NVARCHAR(20) NOT NULL UNIQUE,
    Наименование NVARCHAR(100) NOT NULL,
    Стоимость DECIMAL(10, 2) NOT NULL,
    СрокВыполнения INT NOT NULL, -- в днях
    СреднееОтклонение INT NULL, -- в днях
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица заказов
CREATE TABLE Заказы (
    ID_заказа INT IDENTITY(1,1) PRIMARY KEY,
    ID_пациента INT NOT NULL,
    ДатаСоздания DATETIME NOT NULL DEFAULT GETDATE(),
    СтатусЗаказа NVARCHAR(20) NOT NULL DEFAULT 'Создан',
    ВремяВыполнения INT NULL, -- в днях
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL,
    CONSTRAINT FK_Заказы_Пациенты FOREIGN KEY (ID_пациента) REFERENCES Пациенты(ID_пациента)
);

-- Таблица связи заказов и услуг (многие ко многим)
CREATE TABLE ЗаказыУслуги (
    ID_заказа_услуги INT IDENTITY(1,1) PRIMARY KEY,
    ID_заказа INT NOT NULL,
    ID_услуги INT NOT NULL,
    СтатусУслуги NVARCHAR(20) NOT NULL DEFAULT 'Назначена',
    CONSTRAINT FK_ЗаказыУслуги_Заказы FOREIGN KEY (ID_заказа) REFERENCES Заказы(ID_заказа),
    CONSTRAINT FK_ЗаказыУслуги_Услуги FOREIGN KEY (ID_услуги) REFERENCES Услуги(ID_услуги)
);

-- Таблица анализаторов
CREATE TABLE Анализаторы (
    ID_анализатора INT IDENTITY(1,1) PRIMARY KEY,
    Наименование NVARCHAR(100) NOT NULL,
    Модель NVARCHAR(50) NOT NULL,
    СерийныйНомер NVARCHAR(50) NOT NULL UNIQUE,
    ДатаПоследнегоОбслуживания DATE NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица лаборантов
CREATE TABLE Лаборанты (
    ID_лаборанта INT IDENTITY(1,1) PRIMARY KEY,
    Логин NVARCHAR(50) NOT NULL UNIQUE,
    Пароль NVARCHAR(100) NOT NULL,
    ФИО NVARCHAR(100) NOT NULL,
    ПоследняяДатаВхода DATETIME NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица связи лаборантов и услуг (многие ко многим)
CREATE TABLE ЛаборантыУслуги (
    ID_лаборанта_услуги INT IDENTITY(1,1) PRIMARY KEY,
    ID_лаборанта INT NOT NULL,
    ID_услуги INT NOT NULL,
    CONSTRAINT FK_ЛаборантыУслуги_Лаборанты FOREIGN KEY (ID_лаборанта) REFERENCES Лаборанты(ID_лаборанта),
    CONSTRAINT FK_ЛаборантыУслуги_Услуги FOREIGN KEY (ID_услуги) REFERENCES Услуги(ID_услуги)
);

-- Таблица бухгалтеров
CREATE TABLE Бухгалтеры (
    ID_бухгалтера INT IDENTITY(1,1) PRIMARY KEY,
    Логин NVARCHAR(50) NOT NULL UNIQUE,
    Пароль NVARCHAR(100) NOT NULL,
    ФИО NVARCHAR(100) NOT NULL,
    ПоследняяДатаВхода DATETIME NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица администраторов
CREATE TABLE Администраторы (
    ID_администратора INT IDENTITY(1,1) PRIMARY KEY,
    Логин NVARCHAR(50) NOT NULL UNIQUE,
    Пароль NVARCHAR(100) NOT NULL,
    ПоследняяДатаВхода DATETIME NULL,
    Архивный BIT DEFAULT 0 NOT NULL,
    ДатаАрхивации DATETIME NULL
);

-- Таблица оказанных услуг
CREATE TABLE ОказанныеУслуги (
    ID_оказанной_услуги INT IDENTITY(1,1) PRIMARY KEY,
    ID_заказа_услуги INT NOT NULL,
    ID_лаборанта INT NOT NULL,
    ID_анализатора INT NOT NULL,
    ДатаВремяВыполнения DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_ОказанныеУслуги_ЗаказыУслуги FOREIGN KEY (ID_заказа_услуги) REFERENCES ЗаказыУслуги(ID_заказа_услуги),
    CONSTRAINT FK_ОказанныеУслуги_Лаборанты FOREIGN KEY (ID_лаборанта) REFERENCES Лаборанты(ID_лаборанта),
    CONSTRAINT FK_ОказанныеУслуги_Анализаторы FOREIGN KEY (ID_анализатора) REFERENCES Анализаторы(ID_анализатора)
);

-- Таблица данных о работе анализатора
CREATE TABLE РаботаАнализатора (
    ID_записи INT IDENTITY(1,1) PRIMARY KEY,
    ID_анализатора INT NOT NULL,
    ID_заказа_услуги INT NOT NULL,
    ДатаВремяПоступления DATETIME NOT NULL,
    ДатаВремяВыполнения DATETIME NULL,
    ДлительностьВыполнения INT NULL, -- в секундах
    CONSTRAINT FK_РаботаАнализатора_Анализаторы FOREIGN KEY (ID_анализатора) REFERENCES Анализаторы(ID_анализатора),
    CONSTRAINT FK_РаботаАнализатора_ЗаказыУслуги FOREIGN KEY (ID_заказа_услуги) REFERENCES ЗаказыУслуги(ID_заказа_услуги)
);

-- Таблица истории входа
CREATE TABLE ИсторияВхода (
    ID_записи INT IDENTITY(1,1) PRIMARY KEY,
    ЛогинПользователя NVARCHAR(50) NOT NULL,
    ДатаВремяПопытки DATETIME NOT NULL DEFAULT GETDATE(),
    Успешная BIT NOT NULL,
    IPАдрес NVARCHAR(15) NULL,
    UserAgent NVARCHAR(200) NULL
);

-- Таблица счетов страховым компаниям
CREATE TABLE СчетаСтраховымКомпаниям (
    ID_счета INT IDENTITY(1,1) PRIMARY KEY,
    ID_бухгалтера INT NOT NULL,
    ID_страховой_компании INT NOT NULL,
    НомерСчета NVARCHAR(20) NOT NULL,
    ДатаСоздания DATETIME NOT NULL DEFAULT GETDATE(),
    Сумма DECIMAL(12, 2) NOT NULL,
    Статус NVARCHAR(20) NOT NULL DEFAULT 'Создан',
    CONSTRAINT FK_Счета_Бухгалтеры FOREIGN KEY (ID_бухгалтера) REFERENCES Бухгалтеры(ID_бухгалтера),
    CONSTRAINT FK_Счета_СтраховыеКомпании FOREIGN KEY (ID_страховой_компании) REFERENCES СтраховыеКомпании(ID_страховой_компании)
);

-- Таблица связи счетов и заказов
CREATE TABLE СчетаЗаказы (
    ID_связи INT IDENTITY(1,1) PRIMARY KEY,
    ID_счета INT NOT NULL,
    ID_заказа INT NOT NULL,
    CONSTRAINT FK_СчетаЗаказы_Счета FOREIGN KEY (ID_счета) REFERENCES СчетаСтраховымКомпаниям(ID_счета),
    CONSTRAINT FK_СчетаЗаказы_Заказы FOREIGN KEY (ID_заказа) REFERENCES Заказы(ID_заказа)
);
-- Добавление тестовых данных для типов страховых полисов
INSERT INTO ТипыСтраховыхПолисов (Название, Описание)
VALUES 
('ОМС', 'Обязательное медицинское страхование'),
('ДМС', 'Добровольное медицинское страхование'),
('ВЗР', 'Страхование выезжающих за рубеж');
GO

-- Создание представления для просмотра активных заказов
CREATE VIEW АктивныеЗаказы AS
SELECT 
    з.ID_заказа,
    п.ФИО AS Пациент,
    з.ДатаСоздания,
    з.СтатусЗаказа,
    COUNT(зу.ID_услуги) AS КоличествоУслуг,
    SUM(у.Стоимость) AS ОбщаяСтоимость
FROM Заказы з
JOIN Пациенты п ON з.ID_пациента = п.ID_пациента
JOIN ЗаказыУслуги зу ON з.ID_заказа = зу.ID_заказа
JOIN Услуги у ON зу.ID_услуги = у.ID_услуги
WHERE з.Архивный = 0
GROUP BY з.ID_заказа, п.ФИО, з.ДатаСоздания, з.СтатусЗаказа;
GO

-- Создание представления для истории входа
CREATE VIEW ИсторияВходаПодробно AS
SELECT 
    и.ДатаВремяПопытки,
    и.ЛогинПользователя,
    CASE 
        WHEN а.ID_администратора IS NOT NULL THEN 'Администратор'
        WHEN б.ID_бухгалтера IS NOT NULL THEN 'Бухгалтер'
        WHEN л.ID_лаборанта IS NOT NULL THEN 'Лаборант'
        WHEN п.ID_пациента IS NOT NULL THEN 'Пациент'
        ELSE 'Неизвестный'
    END AS Роль,
    CASE WHEN и.Успешная = 1 THEN 'Успешно' ELSE 'Ошибка' END AS Результат,
    и.IPАдрес,
    и.UserAgent
FROM ИсторияВхода и
LEFT JOIN Администраторы а ON и.ЛогинПользователя = а.Логин
LEFT JOIN Бухгалтеры б ON и.ЛогинПользователя = б.Логин
LEFT JOIN Лаборанты л ON и.ЛогинПользователя = л.Логин
LEFT JOIN Пациенты п ON и.ЛогинПользователя = п.Логин;
GO
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