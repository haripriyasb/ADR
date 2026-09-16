--Check PVS Size

USE ADR_Demo_On;

SELECT 
    database_id,
    persistent_version_store_size_kb/1024.0  AS PVS_Size_MB
FROM sys.dm_tran_persistent_version_store_stats
WHERE database_id = DB_ID();
GO
--

--Check open transaction
SELECT 
 DATEDIFF(MINUTE, transaction_begin_time, GETDATE()) as tran_elapsed_time_mins,
 st.session_id,
 txt.text, 
 DB_NAME(sess.database_id) as database_name ,
 sess.program_name,
 *
FROM
 sys.dm_tran_active_transactions at
 INNER JOIN sys.dm_tran_session_transactions st ON st.transaction_id = at.transaction_id
 LEFT OUTER JOIN sys.dm_exec_sessions sess ON st.session_id = sess.session_id
 LEFT OUTER JOIN sys.dm_exec_connections conn ON conn.session_id = sess.session_id
   OUTER APPLY sys.dm_exec_sql_text(conn.most_recent_sql_handle)  AS txt
ORDER BY
 1 DESC;

 --kill  
 --kill 


--PVS Cleanup
EXEC sys.sp_persistent_version_cleanup @dbname = N'ADR_Demo_On';
GO



SELECT 
    database_id,
    persistent_version_store_size_kb/1024.0  AS PVS_Size_MB
FROM sys.dm_tran_persistent_version_store_stats
WHERE database_id = DB_ID();
GO
--