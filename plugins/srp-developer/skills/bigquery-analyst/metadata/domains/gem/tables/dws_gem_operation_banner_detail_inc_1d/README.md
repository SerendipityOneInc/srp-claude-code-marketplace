# dws_gem_operation_banner_detail_inc_1d

**表全名**: `srpproduct-dc37e.favie_dw.dws_gem_operation_banner_detail_inc_1d`
**层级**: DWS (汇总层)
**业务域**: gem
**表类型**: TABLE
**行数**: 63,042 行
**大小**: 0.01 GB
**创建时间**: 2025-09-10
**最后更新**: 2025-12-09

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 事件发生日期 |
| item_name | STRING | NULLABLE | banner 关联的内容名称 |
| user_media_source | STRING | NULLABLE | 用户媒体来源（根据优先级规则映射得到） |
| is_internal_user | BOOLEAN | NULLABLE | 是否内部用户 |
| user_type | STRING | NULLABLE | 用户类型（如新用户/老用户等） |
| user_tenure_type | STRING | NULLABLE | 用户生命周期类型（如新客/留存/流失等） |
| login_type | STRING | NULLABLE | 用户登录方式（last_day_feature.login_type） |
| platform | STRING | NULLABLE | 用户平台（last_day_feature.platform） |
| app_version | STRING | NULLABLE | 用户使用的 app 版本（last_day_feature.app_version） |
| banner_view_pv | INTEGER | NULLABLE | 曝光次数（true_view_trigger 且 item_type=hashtag 的事件数） |
| banner_view_uv | INTEGER | NULLABLE | 曝光用户数（去重 device_id） |
| banner_click_pv | INTEGER | NULLABLE | 点击次数（点击 hashtag banner 进入详情页的事件数） |
| banner_click_uv | INTEGER | NULLABLE | 点击用户数（去重 device_id） |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dws_gem_operation_banner_detail_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:17:46
**扫描工具**: scan_metadata_v2.py
