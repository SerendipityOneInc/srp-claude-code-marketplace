# rpt_gensmo_user_avatar_cnt_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d`
**层级**: RPT (报表层)
**业务域**: other
**表类型**: TABLE
**行数**: 3,385,435 行
**大小**: 0.72 GB
**创建时间**: 2025-11-14
**最后更新**: 2025-12-25

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 分区，日期 |
| device_id | STRING | NULLABLE | 设备ID |
| user_group | STRING | NULLABLE | 用户分组 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期类型（新/老用户） |
| platform | STRING | NULLABLE | 平台类型（iOS、Android等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 国家名称 |
| validated_task_cnt | INTEGER | NULLABLE | 上传照片但未生成avatar任务数量 |
| failed_task_cnt | INTEGER | NULLABLE | avatar生成失败任务数量 |
| discarded_task_cnt | INTEGER | NULLABLE | 生成成功但用户未选择（refine或close）任务数量 |
| refined_task_cnt | INTEGER | NULLABLE | 生成成功且用户refine任务数量 |
| selected_task_cnt | INTEGER | NULLABLE | 生成成功且用户选取任务数量 |
| new_avatar_cnt | INTEGER | NULLABLE | 新头像数量 |
| valid_avatar_cnt | INTEGER | NULLABLE | 有效头像数量 |
| invalid_avatar_cnt | INTEGER | NULLABLE | 无效头像数量 |
| validated_task_device_id | STRING | NULLABLE | 上传照片但未生成avatar任务设备ID |
| failed_task_device_id | STRING | NULLABLE | avatar生成失败任务设备ID |
| discarded_task_device_id | STRING | NULLABLE | 生成成功但用户未选择（refine或close）任务设备ID |
| refined_task_device_id | STRING | NULLABLE | 生成成功且用户refine任务设备ID |
| selected_task_device_id | STRING | NULLABLE | 生成成功且用户选取任务设备ID |
| new_avatar_device_id | STRING | NULLABLE | 新头像设备ID |
| valid_avatar_device_id | STRING | NULLABLE | 有效头像设备ID |
| invalid_avatar_device_id | STRING | NULLABLE | 无效头像设备ID |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_gensmo_user_avatar_cnt_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:05:34
**扫描工具**: scan_metadata_v2.py
