-- Seed database with ADR OFF
USE ADR_Demo_Off;
GO

--Insert 2 million records
SELECT TOP (2000000) 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
    CAST(REPLICATE('A', 200) AS VARCHAR(200)) AS DummyData
INTO dbo.LargeTable
FROM sys.all_objects a, sys.all_objects b;


-- Seed database with ADR ON (identical structure)
USE ADR_Demo_On;
GO

--Insert 2 million records
SELECT TOP (2000000) 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
    CAST(REPLICATE('A', 200) AS VARCHAR(200)) AS DummyData
INTO dbo.LargeTable
FROM sys.all_objects a, sys.all_objects b;

