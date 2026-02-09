# dwd_product_quality_result_integration_inc_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_product_quality_result_integration_inc_1h`
**层级**: DWD (明细层)
**业务域**: product_quality
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-12-08
**最后更新**: 2025-12-08

---

## 📊 表说明

商品数据质量检查小时级汇总表（外表），包含截图、LLM提取、对比结果、Label Studio链接和优先级

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| host | STRING | NULLABLE | - |
| key | STRING | NULLABLE | - |
| url | STRING | NULLABLE | - |
| main_image_url | STRING | NULLABLE | - |
| images_json | STRING | NULLABLE | - |
| is_screenshot_success | BOOLEAN | NULLABLE | - |
| r2_url | STRING | NULLABLE | - |
| screenshot_timestamp | TIMESTAMP | NULLABLE | - |
| is_llm_extraction_success | BOOLEAN | NULLABLE | - |
| extracted_json | STRING | NULLABLE | - |
| website_status | STRING | NULLABLE | - |
| selected_images | STRING | NULLABLE | - |
| is_llm_comparison_success | BOOLEAN | NULLABLE | - |
| comparison_result | STRING | NULLABLE | - |
| comparison_result_json | STRING | NULLABLE | - |
| main_image_width | FLOAT | NULLABLE | - |
| main_image_height | FLOAT | NULLABLE | - |
| crawler_json | STRING | NULLABLE | - |
| content | STRING | NULLABLE | - |
| task_id | INTEGER | NULLABLE | - |
| task_link | STRING | NULLABLE | - |
| linear_priority | STRING | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |
| processed_at | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_product_quality_result_integration_inc_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:57
**扫描工具**: scan_metadata_v2.py
