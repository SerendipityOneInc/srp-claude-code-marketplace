CREATE VIEW `srpproduct-dc37e.favie_dw.dim_bigquery_job_info_full_view`
AS SELECT 
        date(creation_time) as dt,
        user_email,
        job_id,
        total_slot_ms,
        total_bytes_processed,
        query,
        destination_table,
        referenced_tables
    FROM `region-us-east1`.INFORMATION_SCHEMA.JOBS_BY_PROJECT;