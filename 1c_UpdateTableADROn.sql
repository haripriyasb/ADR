-- Run in Session 2 (ADR ON)
USE ADR_Demo_On;
GO

BEGIN TRANSACTION;

-- Mass update
UPDATE dbo.LargeTable 
SET DummyData = REPLICATE('B', 200);

-- Cancel execution immediately (Ctrl + Break)
-- Notice control returns instantly with zero waiting time.

ROLLBACK