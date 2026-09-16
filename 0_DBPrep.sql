USE master;
GO

IF DB_ID(N'ADR_Demo_Off') IS NOT NULL
BEGIN
    ALTER DATABASE ADR_Demo_Off SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ADR_Demo_Off;
END
GO

IF DB_ID(N'ADR_Demo_On') IS NOT NULL
BEGIN
    ALTER DATABASE ADR_Demo_On SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ADR_Demo_On;
END
GO

CREATE DATABASE ADR_Demo_Off;
CREATE DATABASE ADR_Demo_On;
GO


--Set ADR ON;
ALTER DATABASE ADR_Demo_On SET ACCELERATED_DATABASE_RECOVERY = ON;
GO

-- Set both to SIMPLE recovery to minimize log noise during bulk prep
ALTER DATABASE ADR_Demo_Off SET RECOVERY FULL;
ALTER DATABASE ADR_Demo_On SET RECOVERY FULL;
GO

SELECT 
    name AS DatabaseName,
    is_accelerated_database_recovery_on AS ADR_Enabled,
    recovery_model_desc AS RecoveryModel
FROM sys.databases
WHERE name IN (N'ADR_Demo_Off','ADR_Demo_On' );


--Check Log Size
USE ADR_Demo_Off;
SELECT 
    name AS FileName,
    size * 8.0 / 1024 AS Size_MB
FROM sys.database_files
WHERE type_desc = 'LOG';

USE ADR_Demo_On;
SELECT 
    name AS FileName,
    size * 8.0 / 1024 AS Size_MB
FROM sys.database_files
WHERE type_desc = 'LOG';