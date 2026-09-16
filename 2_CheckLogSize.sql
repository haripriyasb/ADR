
--Check Log Size
USE ADR_Demo_Off;
SELECT 
    name AS FileName,
    size * 8.0 / 1024 AS Size_MB,
    space_used_percent = (CONVERT(FLOAT, FILEPROPERTY(name, 'SpaceUsed')) / size) * 100
FROM sys.database_files
WHERE type_desc = 'LOG';

USE ADR_Demo_On;
SELECT 
    name AS FileName,
    size * 8.0 / 1024 AS Size_MB,
    space_used_percent = (CONVERT(FLOAT, FILEPROPERTY(name, 'SpaceUsed')) / size) * 100
FROM sys.database_files
WHERE type_desc = 'LOG';
