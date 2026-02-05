# rpt_favie_gensmo_channel_metric_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-07-10
**最后更新**: 2025-07-10

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
begin
    DELETE FROM favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d
    WHERE dt is not null and dt = dt_param;

    -- 插入新数据
    INSERT INTO favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d (
        dt,

        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,


        -- 浏览指标
        item_task_gen_pv_cnt,

        item_task_complete_pv_cnt,
        item_task_complete_item_cnt,

        item_task_list_pv_cnt,
        item_task_list_item_cnt,

        item_task_detail_pv_cnt,
        item_task_detail_item_cnt,

        -- 点击指标
        item_task_save_cnt,
        item_task_save_item_cnt,

        item_task_unsave_cnt,
        item_task_unsave_item_cnt,

        item_task_like_cnt,
        item_task_like_item_cnt,

        item_task_cancel_like_cnt,
        item_task_cancel_like_item_cnt,

        item_task_share_cnt,
        item_task_share_item_cnt,

        item_task_download_cnt,
        item_task_download_item_cnt,

        item_task_external_jump_cnt,
        item_task_external_jump_item_cnt
    )
    SELECT
        dt,

        -- 用户信息
        platform,
        app_version,
        country_name,
        user_login_type,
        user_tenure_type,
        user_group,

        -- 浏览指标
        item_task_gen_pv_cnt,

        item_task_complete_pv_cnt,
        item_task_complete_item_cnt,

        item_task_list_pv_cnt,
        item_task_list_item_cnt,

        item_task_detail_pv_cnt,
        item_task_detail_item_cnt,

        -- 点击指标
        item_task_save_cnt,
        item_task_save_item_cnt,

        item_task_unsave_cnt,
        item_task_unsave_item_cnt,

        item_task_like_cnt,
        item_task_like_item_cnt,

        item_task_cancel_like_cnt,
        item_task_cancel_like_item_cnt,

        item_task_share_cnt,
        item_task_share_item_cnt,

        item_task_download_cnt,
        item_task_download_item_cnt,

        item_task_external_jump_cnt,
        item_task_external_jump_item_cnt
    FROM favie_rpt.rpt_favie_gensmo_channel_metric_inc_1d_function(dt_param);
end
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
