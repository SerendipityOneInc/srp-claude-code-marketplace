CREATE VIEW `srpproduct-dc37e.favie_dw.dim_gem_bot_account_view`
AS SELECT  
        _id,
        id,
        uid,
        device_id,
        device_ids,
        name,
        email,
        phone_number,
        description,
        firebase_uid,
        is_active,
        bio,
        avatar,
        is_bot,
        created_at,
        updated_at
    FROM favie_dw.dim_gem_account_view
    where coalesce(lower(trim(is_bot)), 'false') = 'true';