CREATE TABLE Клиенты (
    ID_клиента INT PRIMARY KEY IDENTITY(1,1),
    Фамилия NVARCHAR(50) NOT NULL,
    Имя NVARCHAR(50) NOT NULL,
    Отчество NVARCHAR(50),
    Телефон NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    Адрес NVARCHAR(200),
    Дата_регистрации DATE DEFAULT GETDATE()
);

-- Таблица "Автомобили"
CREATE TABLE Автомобили (
    ID_автомобиля INT PRIMARY KEY IDENTITY(1,1),
    ID_клиента INT NOT NULL,
    Марка NVARCHAR(50) NOT NULL,
    Модель NVARCHAR(50) NOT NULL,
    Год_выпуска INT,
    VIN_номер NVARCHAR(17),
    Номерной_знак NVARCHAR(15),
    Пробег INT,
    FOREIGN KEY (ID_клиента) REFERENCES Клиенты(ID_клиента)
);

-- Таблица "Услуги"
CREATE TABLE Услуги (
    ID_услуги INT PRIMARY KEY IDENTITY(1,1),
    Наименование NVARCHAR(100) NOT NULL,
    Описание NVARCHAR(500),
    Стоимость DECIMAL(10,2) NOT NULL,
    Длительность_выполнения INT  -- в минутах
);

-- Таблица "Запчасти"
CREATE TABLE Запчасти (
    ID_запчасти INT PRIMARY KEY IDENTITY(1,1),
    Наименование NVARCHAR(100) NOT NULL,
    Описание NVARCHAR(500),
    Артикул NVARCHAR(50),
    Производитель NVARCHAR(100),
    Цена DECIMAL(10,2) NOT NULL,
    Количество_на_складе INT DEFAULT 0
);

-- Таблица "Сотрудники"
CREATE TABLE Сотрудники (
    ID_сотрудника INT PRIMARY KEY IDENTITY(1,1),
    Фамилия NVARCHAR(50) NOT NULL,
    Имя NVARCHAR(50) NOT NULL,
    Отчество NVARCHAR(50),
    Должность NVARCHAR(100) NOT NULL,
    Телефон NVARCHAR(20),
    Email NVARCHAR(100),
    Дата_приема DATE NOT NULL,
    Зарплата DECIMAL(10,2)
);

-- Таблица "Заказы"
CREATE TABLE Заказы (
    ID_заказа INT PRIMARY KEY IDENTITY(1,1),
    ID_автомобиля INT NOT NULL,
    ID_сотрудника INT NOT NULL,
    Дата_создания DATETIME DEFAULT GETDATE(),
    Дата_начала_работ DATETIME,
    Дата_окончания_работ DATETIME,
    Статус NVARCHAR(50) DEFAULT 'Новый',
    Описание_проблемы NVARCHAR(1000),
    Общая_стоимость DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (ID_автомобиля) REFERENCES Автомобили(ID_автомобиля),
    FOREIGN KEY (ID_сотрудника) REFERENCES Сотрудники(ID_сотрудника)
);

-- Таблица "Состав_заказа_услуги" (связь многие-ко-многим между Заказы и Услуги)
CREATE TABLE Состав_заказа_услуги (
    ID_заказа INT NOT NULL,
    ID_услуги INT NOT NULL,
    Количество INT DEFAULT 1,
    Стоимость_на_момент_выполнения DECIMAL(10,2),
    PRIMARY KEY (ID_заказа, ID_услуги),
    FOREIGN KEY (ID_заказа) REFERENCES Заказы(ID_заказа),
    FOREIGN KEY (ID_услуги) REFERENCES Услуги(ID_услуги)
);

-- Таблица "Состав_заказа_запчасти" (связь многие-ко-многим между Заказы и Запчасти)
CREATE TABLE Состав_заказа_запчасти (
    ID_заказа INT NOT NULL,
    ID_запчасти INT NOT NULL,
    Количество INT DEFAULT 1,
    Цена_на_момент_продажи DECIMAL(10,2),
    PRIMARY KEY (ID_заказа, ID_запчасти),
    FOREIGN KEY (ID_заказа) REFERENCES Заказы(ID_заказа),
    FOREIGN KEY (ID_запчасти) REFERENCES Запчасти(ID_запчасти)
);

-- Таблица "График_работы"
CREATE TABLE График_работы (
    ID_записи INT PRIMARY KEY IDENTITY(1,1),
    ID_сотрудника INT NOT NULL,
    Дата DATE NOT NULL,
    Время_начала TIME NOT NULL,
    Время_окончания TIME NOT NULL,
    FOREIGN KEY (ID_сотрудника) REFERENCES Сотрудники(ID_сотрудника)
);