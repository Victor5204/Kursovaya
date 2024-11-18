SET QUOTED_IDENTIFIER OFF;
GO
USE [Kursovaya];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Employees_Batches]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Employees] DROP CONSTRAINT [FK_Employees_Batches];
GO
IF OBJECT_ID(N'[dbo].[FK_Manufactured_parts_Batches]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Manufactured_parts] DROP CONSTRAINT [FK_Manufactured_parts_Batches];
GO
IF OBJECT_ID(N'[dbo].[FK_Test_report_Tested_parts]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Test_report] DROP CONSTRAINT [FK_Test_report_Tested_parts];
GO
IF OBJECT_ID(N'[dbo].[FK_Tested_parts_Batches]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tested_parts] DROP CONSTRAINT [FK_Tested_parts_Batches];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Admins]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Admins];
GO
IF OBJECT_ID(N'[dbo].[Batches]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Batches];
GO
IF OBJECT_ID(N'[dbo].[Employees]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Employees];
GO
IF OBJECT_ID(N'[dbo].[Manufactured_parts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Manufactured_parts];
GO
IF OBJECT_ID(N'[dbo].[Test_report]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Test_report];
GO
IF OBJECT_ID(N'[dbo].[Tested_parts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tested_parts];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Admins'
CREATE TABLE [dbo].[Admins] (
    [Id] int  NOT NULL,
    [login] nvarchar(40)  NOT NULL,
    [password] nvarchar(40)  NOT NULL
);
GO

-- Creating table 'Batches'
CREATE TABLE [dbo].[Batches] (
    [id] int  NOT NULL,
    [Batch_Num] nchar(10)  NOT NULL
);
GO

-- Creating table 'Employees'
CREATE TABLE [dbo].[Employees] (
    [id] int  NOT NULL,
    [Full_Name] nvarchar(60)  NOT NULL,
    [DoB] nvarchar(10)  NOT NULL,
    [Post] nvarchar(50)  NOT NULL,
    [Batch_id] int  NOT NULL
);
GO

-- Creating table 'Manufactured_parts'
CREATE TABLE [dbo].[Manufactured_parts] (
    [id] int  NOT NULL,
    [Batch_id] int  NOT NULL,
    [Articul] int  NOT NULL,
    [Name] nvarchar(40)  NOT NULL,
    [Production_Date] nvarchar(10)  NOT NULL,
    [Workspace_Num] nchar(10)  NOT NULL,
    [Type] nvarchar(60)  NOT NULL
);
GO

-- Creating table 'Test_report'
CREATE TABLE [dbo].[Test_report] (
    [id] int  NOT NULL,
    [Test_part_id] int  NOT NULL,
    [Articul] int  NOT NULL,
    [Name] nvarchar(40)  NOT NULL,
    [Test_Date] nvarchar(10)  NOT NULL,
    [Liable_person] nvarchar(40)  NOT NULL,
    [Discription] nvarchar(250)  NOT NULL
);
GO

-- Creating table 'Tested_parts'
CREATE TABLE [dbo].[Tested_parts] (
    [id] int  NOT NULL,
    [Batch_id] int  NOT NULL,
    [Articul] int  NOT NULL,
    [Name] nvarchar(40)  NOT NULL,
    [Production_Date] nvarchar(10)  NOT NULL,
    [Workspace_Num] int  NOT NULL,
    [Result] nchar(10)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Admins'
ALTER TABLE [dbo].[Admins]
ADD CONSTRAINT [PK_Admins]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [id] in table 'Batches'
ALTER TABLE [dbo].[Batches]
ADD CONSTRAINT [PK_Batches]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [PK_Employees]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Manufactured_parts'
ALTER TABLE [dbo].[Manufactured_parts]
ADD CONSTRAINT [PK_Manufactured_parts]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Test_report'
ALTER TABLE [dbo].[Test_report]
ADD CONSTRAINT [PK_Test_report]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- Creating primary key on [id] in table 'Tested_parts'
ALTER TABLE [dbo].[Tested_parts]
ADD CONSTRAINT [PK_Tested_parts]
    PRIMARY KEY CLUSTERED ([id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Batch_id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Batches]
    FOREIGN KEY ([Batch_id])
    REFERENCES [dbo].[Batches]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Employees_Batches'
CREATE INDEX [IX_FK_Employees_Batches]
ON [dbo].[Employees]
    ([Batch_id]);
GO

-- Creating foreign key on [Batch_id] in table 'Manufactured_parts'
ALTER TABLE [dbo].[Manufactured_parts]
ADD CONSTRAINT [FK_Manufactured_parts_Batches]
    FOREIGN KEY ([Batch_id])
    REFERENCES [dbo].[Batches]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Manufactured_parts_Batches'
CREATE INDEX [IX_FK_Manufactured_parts_Batches]
ON [dbo].[Manufactured_parts]
    ([Batch_id]);
GO

-- Creating foreign key on [Batch_id] in table 'Tested_parts'
ALTER TABLE [dbo].[Tested_parts]
ADD CONSTRAINT [FK_Tested_parts_Batches]
    FOREIGN KEY ([Batch_id])
    REFERENCES [dbo].[Batches]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Tested_parts_Batches'
CREATE INDEX [IX_FK_Tested_parts_Batches]
ON [dbo].[Tested_parts]
    ([Batch_id]);
GO

-- Creating foreign key on [Test_part_id] in table 'Test_report'
ALTER TABLE [dbo].[Test_report]
ADD CONSTRAINT [FK_Test_report_Tested_parts]
    FOREIGN KEY ([Test_part_id])
    REFERENCES [dbo].[Tested_parts]
        ([id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Test_report_Tested_parts'
CREATE INDEX [IX_FK_Test_report_Tested_parts]
ON [dbo].[Test_report]
    ([Test_part_id]);
GO