# gem_operation_refer_duration_inc_1d_function

**函数全名**: `srpproduct-dc37e.favie_rpt.gem_operation_refer_duration_inc_1d_function`
**类型**: TABLE_VALUED_FUNCTION
**函数分类**: metric
**语言**: SQL
**创建时间**: 2025-08-19
**最后更新**: 2025-08-19

---

## 📝 函数说明

暂无描述

---

## 📋 参数定义

| 参数名 | 类型 | 模式 |
|--------|------|------|
| dt_param | StandardSqlDataType(type_kind=<StandardSqlTypeNames.DATE: 'DATE'>, ...) | None |

**返回类型**: 无

---

## 🔗 使用的表

- `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` (dws_gensmo_user_group_inc_1d)
- `srpproduct-dc37e.favie_dw.dws_gensmo_refer_general_metrics_inc_1d` (dws_gensmo_refer_general_metrics_inc_1d)

---

## 💻 函数定义

```sql
SELECT
    m.dt,
    m.refer,
    m.data_name,
    m.data_value,
    m.device_id,
    n.user_group,
    n.platform,
    n.app_version,
    n.user_login_type,
    n.user_tenure_type
    FROM `srpproduct-dc37e.favie_dw.dws_gensmo_refer_general_metrics_inc_1d` m
    LEFT JOIN `srpproduct-dc37e.favie_dw.dws_gensmo_user_group_inc_1d` n
    ON m.dt=n.dt and m.device_id=n.device_id
    where m.dt=dt_param
```

---

**文档生成**: 2026-01-30 13:38:34
**扫描工具**: scan_functions.py
