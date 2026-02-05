# dwd_favie_gensmo_user_recap_inc_1d_procedure

**函数全名**: `srpproduct-dc37e.favie_dw.dwd_favie_gensmo_user_recap_inc_1d_procedure`
**类型**: PROCEDURE
**语言**: SQL
**创建时间**: 2025-11-18
**最后更新**: 2025-11-18

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
      -- 删除目标日期的现有数据
      DELETE FROM `favie_dw.dwd_favie_gensmo_user_recap_inc_1d`
      WHERE dt = dt_param;

      -- 插入数据
      INSERT INTO `favie_dw.dwd_favie_gensmo_user_recap_inc_1d` (
      user_id
      ,dt
      ,event_type
      ,event_timestamp
      ,session_id
      ,item_name
      ,item_id
      ,item_type
      ,item_index
      ,image_url
      ,moodboard_content
      )
      SELECT
      user_id
      ,dt
      ,event_type
      ,event_timestamp
      ,session_id
      ,item_name
      ,item_id
      ,item_type
      ,item_index
      ,image_url
      ,moodboard_content
      FROM `favie_dw.dwd_gensmo_user_recap_inc_1d_function`(dt_param);
END
```

---

**文档生成**: 2026-01-30 14:24:22
**关联方式**: 按函数名匹配
