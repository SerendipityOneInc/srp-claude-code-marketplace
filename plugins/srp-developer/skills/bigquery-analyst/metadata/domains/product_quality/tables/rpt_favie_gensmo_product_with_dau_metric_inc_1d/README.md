# rpt_favie_gensmo_product_with_dau_metric_inc_1d

**表全名**: `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d`
**层级**: RPT (报表层)
**业务域**: product_quality
**表类型**: TABLE
**行数**: 7,683,740 行
**大小**: 0.63 GB
**创建时间**: 2025-07-15
**最后更新**: 2026-01-30

---

## 📊 表说明

暂无描述

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | NULLABLE | 指标数据日期 |
| platform | STRING | NULLABLE | 平台类型（iOS、Android 等） |
| app_version | STRING | NULLABLE | 应用版本 |
| country_name | STRING | NULLABLE | 用户所属国家名称 |
| user_login_type | STRING | NULLABLE | 用户登录类型（匿名、注册等） |
| user_tenure_type | STRING | NULLABLE | 用户使用周期分类（新用户、老用户） |
| user_group | STRING | NULLABLE | 用户分组分类 |
| active_user_d1_cnt | INTEGER | NULLABLE | 日活跃用户数 |
| product_external_jump_click_cnt | INTEGER | NULLABLE | 商品外部跳转点击次数 |
| product_external_jump_click_user_cnt | INTEGER | NULLABLE | 商品外部跳转用户数 |
| product_detail_pv_cnt | INTEGER | NULLABLE | 商品详情卡片浏览次数 |
| product_detail_user_cnt | INTEGER | NULLABLE | 商品详情卡片访问用户数 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_rpt.rpt_favie_gensmo_product_with_dau_metric_inc_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:02:17
**扫描工具**: scan_metadata_v2.py
