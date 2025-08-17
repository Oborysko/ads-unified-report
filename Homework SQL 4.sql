with union_data as(
	select fb.ad_date,
			'Facebook Ads' as media_source,
			campaign.campaign_name,
			adset.adset_name,
			fb.spend,
			fb.impressions,
			fb.reach,
			fb.clicks,
			fb.leads,
			fb.value
	from facebook_ads_basic_daily as fb
	left join facebook_adset as adset
		on fb.adset_id = adset.adset_id
	left join facebook_campaign as campaign
		on fb.campaign_id = campaign.campaign_id
		
	union all
		select g.ad_date,
			'Google Ads' as media_source,
			g.campaign_name,
			g.adset_name,
			g.spend,
			g.impressions,
			g.reach,
			g.clicks,
			g.leads,
			g.value
	from google_ads_basic_daily as g
	)
	
	select
		ad_date,
		media_source,
		campaign_name,
		adset_name,
	sum(spend) as total_spend,
	sum(impressions) as total_impressions,
	sum(clicks) as total_clicks,
	sum(value) as total_value
	from union_data
	group by ad_date, media_source, campaign_name, adset_name
	order by ad_date;
	
	