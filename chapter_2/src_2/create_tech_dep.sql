CREATE TABLE
	golden_layer.technical_data AS
SELECT
	fnu.unique_id,
	da.address,
	da.mac_address,
	da.ip_address,
	fnu.download_speed,
	fnu.upload_speed,
	ROUND((fnu.session_duration/60), 1) as min_session_duration,
	CASE 
        WHEN fnu.download_speed < 50 OR fnu.upload_speed < 30 OR fnu.session_duration/60 < 1 THEN true
        ELSE false
    END AS technical_issue
FROM
	silver_layer.fact_network_usage fnu
JOIN
	silver_layer.dim_address da
ON
	fnu.unique_id = da.unique_id
    