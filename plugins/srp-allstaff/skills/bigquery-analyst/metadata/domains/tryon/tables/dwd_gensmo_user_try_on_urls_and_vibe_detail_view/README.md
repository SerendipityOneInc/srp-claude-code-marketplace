# dwd_gensmo_user_try_on_urls_and_vibe_detail_view

**表全名**: `srpproduct-dc37e.favie_dw.dwd_gensmo_user_try_on_urls_and_vibe_detail_view`
**层级**: DWD (明细层)
**业务域**: other
**表类型**: VIEW
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-08-21
**最后更新**: 2025-08-21

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| created_time | STRING | NULLABLE | - |
| user_id | STRING | NULLABLE | - |
| try_on_task_id | STRING | NULLABLE | - |
| model_id | STRING | NULLABLE | - |
| model_type | STRING | NULLABLE | - |
| user_image_url | STRING | NULLABLE | - |
| try_on_preview_url | STRING | NULLABLE | - |
| try_on_url | STRING | NULLABLE | - |
| background_prompt_offered | STRING | NULLABLE | - |
| outfit_enthusiast_text | STRING | NULLABLE | - |
| change_background_prompt | STRING | NULLABLE | - |
| change_background_input_image_url | STRING | NULLABLE | - |
| change_background_image_url | STRING | NULLABLE | - |
| change_background_status | STRING | NULLABLE | - |

---

## 🔗 数据血缘

### 上游依赖表

- `srpproduct-dc37e.favie_mongodb_integration_airbyte.try_on_change_background_task` (try_on_change_background_task)
- `srpproduct-dc37e.favie_mongodb_integration_airbyte.try_on_task` (try_on_task)

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_gensmo_user_try_on_urls_and_vibe_detail_view`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:14:46
**扫描工具**: scan_metadata_v2.py
