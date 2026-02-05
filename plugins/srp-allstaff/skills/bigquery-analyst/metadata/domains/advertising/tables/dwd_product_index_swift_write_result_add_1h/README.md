# dwd_product_index_swift_write_result_add_1h

**表全名**: `srpproduct-dc37e.favie_dw.dwd_product_index_swift_write_result_add_1h`
**层级**: DWD (明细层)
**业务域**: advertising
**表类型**: EXTERNAL
**行数**: 0 行
**大小**: 0.00 GB
**创建时间**: 2025-11-02
**最后更新**: 2025-11-02

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| f_sku_id | STRING | NULLABLE | - |
| write_status | STRING | NULLABLE | - |
| error_message | STRING | NULLABLE | - |
| retry_count | INTEGER | NULLABLE | - |
| write_timestamp | TIMESTAMP | NULLABLE | - |
| dt | STRING | NULLABLE | - |
| hour | STRING | NULLABLE | - |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dwd_product_index_swift_write_result_add_1h`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:15:44
**扫描工具**: scan_metadata_v2.py
