# dim_favie_decofy_user_account_scd2_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_decofy_user_account_scd2_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-12-11
**最后更新**: 2025-12-11

---

## 📝 函数说明



---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: None

---

## 💻 函数定义

```sql
BEGIN
    -- 先将 TABLE FUNCTION 结果写入临时表
    CREATE OR REPLACE TEMP TABLE tmp_changed_user AS
    SELECT
        scd2_sk,
        created_at,
        updated_at,
        user_id,
        device_ids,
        user_name,
        user_email,
        user_type,
        is_internal_user,
        first_access_info,
        last_access_info,
        first_geo_address,
        permanent_geo_address,
        is_new_user
    FROM favie_dw.dim_favie_decofy_user_account_change_function(dt_param);

    -- 使用BigQuery事务，保证MERGE和INSERT原子性，防止拉链断档
    BEGIN TRANSACTION;
        -- 1. 先关闭旧段
        MERGE favie_dw.dim_favie_decofy_user_account_scd2_1d AS t
        USING (SELECT * FROM tmp_changed_user WHERE scd2_sk IS NOT NULL) AS all_changed_user_info
        ON t.scd2_sk = all_changed_user_info.scd2_sk
        WHEN MATCHED THEN
            UPDATE SET end_date = DATE_SUB(dt_param, INTERVAL 1 DAY), is_current = FALSE;

        -- 2. 再插入新段
        INSERT INTO favie_dw.dim_favie_decofy_user_account_scd2_1d (
            scd2_sk,
            user_id,
            start_date,
            end_date,
            is_current,
            updated_at,
            created_at,
            device_ids,
            user_name,
            user_email,
            user_type,
            is_internal_user,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        )
        SELECT
            GENERATE_UUID() as scd2_sk,
            user_id,
            if(is_new_user, date(created_at), dt_param) as start_date,
            DATE('9999-12-31') as end_date,
            TRUE as is_current,
            updated_at,
            created_at,
            device_ids,
            user_name,
            user_email,
            user_type,
            is_internal_user,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        FROM tmp_changed_user;
    COMMIT TRANSACTION;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
