# Accelerated Database Recovery (ADR) in SQL Server

Demo scripts and slides from my session **Accelerated Database Recovery (ADR)**, presented at SQL Saturday Boston on October 3, 2026.

ADR changes how SQL Server recovers a database. Traditionally, recovery and rollback time grows with your longest-running transaction. ADR, introduced in SQL Server 2019, uses a persistent version store (PVS) so that rollback is nearly instant and the transaction log can be truncated aggressively. These scripts show the difference side by side.

## What the demo shows

- A long-running mass update rolled back with ADR **off** (slow rollback you can watch in `sys.dm_exec_requests`)
- The same update rolled back with ADR **on** (control returns almost immediately)
- Transaction log growth with and without ADR
- How to monitor the persistent version store and the open transactions that prevent its cleanup

## Requirements

- SQL Server 2019 or later (ADR is available in Standard and Enterprise editions)
- A non-production test instance
- SQL Server Management Studio (SSMS) or Azure Data Studio, with two query windows open

## Run the demo

| Step | Script | What it does |
|---|---|---|
| 0 | `0_DBPrep.sql` | Creates two databases: `ADR_Demo_Off` and `ADR_Demo_On` (ADR enabled) |
| 1a | `1a_SeedData.sql` | Loads 2 million rows into `dbo.LargeTable` in both databases |
| 1b | `1b_UpdateTableADROff.sql` | Session 1: mass update with ADR off. Cancel after 5–10 seconds and watch the rollback |
| 1c | `1c_UpdateTableADROn.sql` | Session 2: same update with ADR on. Cancel and note the instant rollback |
| 2 | `2_CheckLogSize.sql` | Compares transaction log size and usage across both databases |
| 3 | `3_CleanupPVS.sql` | Checks PVS size and finds open transactions that block PVS cleanup |

## Files

- `*.sql`: demo scripts, run in numbered order
- `Accelerated Database Recovery.pptx`: session slides

## Learn more

- [Accelerated database recovery (Microsoft Learn)](https://learn.microsoft.com/en-us/sql/relational-databases/accelerated-database-recovery-concepts)
- Blog: [gohigh.substack.com](https://gohigh.substack.com)

> These scripts drop and recreate databases. Run them only on a test instance.
