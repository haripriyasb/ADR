-- Run in Session 1 (ADR OFF)
USE ADR_Demo_Off;
GO

BEGIN TRANSACTION;

-- Mass update to dirty thousands of pages
UPDATE dbo.LargeTable 
SET DummyData = REPLICATE('B', 200);

-- After 5-10 seconds, cancel execution manually (Ctrl + Break)
-- Then check rollback status in another window using:
-- SELECT session_id, percent_complete, command, wait_type FROM sys.dm_exec_requests WHERE command LIKE '%ROLLBACK%';

ROLLBACK