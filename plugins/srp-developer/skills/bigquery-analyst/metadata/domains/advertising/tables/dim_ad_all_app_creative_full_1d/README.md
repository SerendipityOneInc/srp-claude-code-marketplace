# dim_ad_all_app_creative_full_1d

**表全名**: `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d`
**层级**: 未分类
**业务域**: advertising
**表类型**: TABLE
**行数**: 859,680 行
**大小**: 1.97 GB
**创建时间**: 2025-07-07
**最后更新**: 2026-01-30

---

## 📊 表说明

TikTok广告创意维度表完整版，存储图片和视频创意信息

---

## 📋 字段定义

| 字段名 | 类型 | 模式 | 说明 |
|--------|------|------|------|
| dt | DATE | REQUIRED | 分区日期字段 |
| source | STRING | REQUIRED | 数据来源，固定值为Tiktok |
| app_name | STRING | NULLABLE | 应用名称：Gensmo、Decofy或UNKNOWN |
| account_id | STRING | NULLABLE | 账户ID，对应advertiser_id |
| account_name | STRING | NULLABLE | 账户名称 |
| external_creative_id | STRING | NULLABLE | 外部创意ID，对应image_id或video_id |
| external_creative_name | STRING | NULLABLE | 外部创意名称，对应file_name |
| external_creative_url | STRING | NULLABLE | 外部创意URL，对应image_url或preview_url |
| external_creative_cover_url | STRING | NULLABLE | 外部创意封面URL，仅视频有值 |
| creative_type | STRING | REQUIRED | 创意类型：image或video |
| creative_status | STRING | NULLABLE | 创意状态, NORMAL,EXPIRED,UNKNOWN |
| internal_creative_id | STRING | NULLABLE | 内部创意ID |
| format | STRING | NULLABLE | 文件格式 |
| height | INTEGER | NULLABLE | 高度 |
| width | INTEGER | NULLABLE | 宽度 |
| size | INTEGER | NULLABLE | 文件大小 |
| creative_video_duration | FLOAT | NULLABLE | 视频时长（秒），仅视频有值 |
| creative_allowed_placements | STRING | NULLABLE | 允许的投放位置，仅视频有值 |
| creative_video_bit_rate | FLOAT | NULLABLE | 视频比特率，仅视频有值 |
| updated_at | TIMESTAMP | NULLABLE | 更新时间 |
| created_at | TIMESTAMP | NULLABLE | 创建时间 |
| upload_r2_process_at | STRING | NULLABLE | 上传到R2的处理时间 |

---

## 🔍 查询示例

```sql
-- 查询最近7天数据
SELECT
    dt,
    COUNT(*) as cnt
FROM `srpproduct-dc37e.favie_dw.dim_ad_all_app_creative_full_1d`
WHERE dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY dt
ORDER BY dt DESC;
```

---

**文档生成**: 2026-01-30 13:06:40
**扫描工具**: scan_metadata_v2.py
