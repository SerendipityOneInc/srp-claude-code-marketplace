# dws_favie_gem_search_query_cube_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dws_favie_gem_search_query_cube_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-10-08
**最后更新**: 2025-10-08

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
      DELETE FROM `favie_dw.dws_favie_gem_search_query_cube_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dws_favie_gem_search_query_cube_inc_1d` (
        raw_query,
        qr_query,
        qp_query,
        query_modality,
        query_source,
        query_intention_level1,
        query_intention_level2,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        raw_query_word_amt,
        qr_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        query_user_uniq_cnt,
        dt
      )
      SELECT
        raw_query,
        qr_query,
        qp_query,
        query_modality,
        query_source,
        query_intention_level1,
        query_intention_level2,
        user_type,
        user_login_type,
        user_tenure_type,
        country_name,
        platform,
        app_version,
        ad_source,
        ad_campaign_id,
        ad_group_id,
        ad_id,
        raw_query_word_amt,
        qr_query_word_amt,
        qp_query_word_amt,
        query_cnt,
        query_user_uniq_cnt,
        dt
      FROM `favie_dw.dws_favie_gem_search_query_cube_inc_1d_function`(dt_param);

END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
