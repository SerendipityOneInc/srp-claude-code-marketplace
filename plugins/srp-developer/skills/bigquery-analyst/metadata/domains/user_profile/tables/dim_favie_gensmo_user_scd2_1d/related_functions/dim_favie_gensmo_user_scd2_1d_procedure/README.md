# dim_favie_gensmo_user_scd2_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dim_favie_gensmo_user_scd2_1d_procedure`
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
        start_date,
        end_date,
        is_current,

        device_id,
        created_at,
        first_event_timestamp,
        is_internal_user,
        user_type,
        user_accounts,
        first_access_info,
        last_access_info,
        first_geo_address,
        permanent_geo_address,
        is_new_user
    FROM favie_dw.dim_favie_gensmo_user_change_function(dt_param);

    -- 使用BigQuery事务，保证MERGE和INSERT原子性，防止拉链断档
    BEGIN TRANSACTION;
        -- 1. 只需要更新信息的用户
        -- 因为初始化的全量用户来自账号表，这些用户在未来事件更新会遇到start_date和dt_param相同，此时不需要创建新记录，只需要补全访问信息即可
        MERGE favie_dw.dim_favie_gensmo_user_scd2_1d AS t1
        USING (SELECT * FROM tmp_changed_user WHERE is_new_user = FALSE AND start_date = dt_param) AS t2
        ON t1.scd2_sk = t2.scd2_sk
        WHEN MATCHED THEN
            UPDATE SET 
                scd2_updated_at = CURRENT_TIMESTAMP(),
                first_access_info = t2.first_access_info,
                last_access_info = t2.last_access_info,
                first_geo_address = t2.first_geo_address,
                permanent_geo_address = t2.permanent_geo_address
                ;


        -- 2. 需要先关闭旧段的用户
        MERGE favie_dw.dim_favie_gensmo_user_scd2_1d AS t1
        USING (SELECT * FROM tmp_changed_user WHERE is_new_user = FALSE AND start_date < dt_param) AS t2
        ON t1.scd2_sk = t2.scd2_sk
        WHEN MATCHED THEN
            UPDATE SET 
                end_date = DATE_SUB(dt_param, INTERVAL 1 DAY), 
                is_current = FALSE,
                scd2_updated_at = CURRENT_TIMESTAMP()
                ;

        -- 3. 需要再插入新段的用户
        INSERT INTO favie_dw.dim_favie_gensmo_user_scd2_1d (
            scd2_sk,
            start_date,
            end_date,
            is_current,
            scd2_created_at,
            scd2_updated_at,

            device_id,
            created_at,
            is_internal_user,
            user_type,
            user_accounts,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        )
        SELECT
            GENERATE_UUID() as scd2_sk,
            if(is_new_user,date(first_event_timestamp),dt_param) as start_date,
            DATE('9999-12-31') as end_date,
            TRUE as is_current,
            CURRENT_TIMESTAMP() as scd2_created_at,
            CURRENT_TIMESTAMP() as scd2_updated_at,

            device_id,
            if(is_new_user,first_event_timestamp,created_at) as created_at,
            is_internal_user,
            user_type,
            user_accounts,
            first_access_info,
            last_access_info,
            first_geo_address,
            permanent_geo_address
        FROM tmp_changed_user
        WHERE is_new_user = TRUE OR start_date < dt_param;
    COMMIT TRANSACTION;
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
