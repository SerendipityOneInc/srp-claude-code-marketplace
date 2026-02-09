CREATE VIEW `srpproduct-dc37e.favie_dw.product_detail_price_analysis_view`
AS select 
      f_sku_id,
      site,
      link,
      rrp,
      price,
      round(avg_price,0) as avg_price,
      f_historical_prices,
      round(abs(price - avg_price)/avg_price *100,0) as change_rate,
      updates_at,
      dt
    from (
      select
        f_sku_id,
        f_spu_id,
        site,
        link,
        cast(json_extract_scalar(price,"$.value") as int64) as price ,
        json_extract_scalar(rrp,"$.value") as rrp ,
        favie_dw.calculate_moving_average_without_denoise(f_historical_prices) as avg_price,
        f_historical_prices,
        source_1_updates_at,
        source_3_updates_at,
        CAST(TIMESTAMP_SECONDS(greatest(coalesce(source_1_updates_at,source_3_updates_at),coalesce(source_3_updates_at,source_1_updates_at))) as DATE) as updates_at,
        dt
      from(
        SELECT 
          f_sku_id,
          f_spu_id,
          site,
          link,
          price,
          rrp,
          f_historical_prices,
          cast(json_extract_scalar(f_meta,"$.source_1_updates_at") as int64) as source_1_updates_at,
          cast(json_extract_scalar(f_meta,"$.source_3_updates_at") as int64) as source_3_updates_at,
          dt
        FROM `srpproduct-dc37e.favie_dw.dwd_favie_product_detail_full_1d`
        where f_historical_prices is not null
      )
    );