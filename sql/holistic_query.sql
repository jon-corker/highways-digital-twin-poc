-- Holistic SQL query, returning a geojson result from the full service layer

WITH selected_network AS (
  -- Select authoritative network geometry by section
  SELECT 
    * 
  FROM 
    service.road_authoritative_network 
  WHERE 
    section_ref = : section_ref
), 
historic_condition AS (
  -- Select historic condition points by section
  SELECT 
    * 
  FROM 
    service.road_scanner_condition 
  WHERE 
    section_ref = : section_ref
), 
forecast_condition AS (
  -- Select forecast condition points by section
  SELECT 
    * 
  FROM 
    service.road_scanner_forecast 
  WHERE 
    section_ref = : section_ref
), 
geotechnical_inventory AS (
  -- Spatial intersection with geotechnical polygons
  SELECT 
    g.* 
  FROM 
    service.ground_geotechnical_inventory_network_view g 
    JOIN selected_network n ON ST_Intersects(g.geom, n.geom)
), 
environmental_context AS (
  -- Spatial intersection with environmental polygons
  SELECT 
    e.* 
  FROM 
    service.environment_isobasin_view e 
    JOIN selected_network n ON ST_Intersects(e.geom, n.geom)
) 
SELECT 
  jsonb_build_object(
    'type', 
    'FeatureCollection', 
    'authoritative network', 
    (
      SELECT 
        jsonb_agg(
          ST_AsGeoJSON(n.*):: jsonb
        ) 
      FROM 
        selected_network n
    ), 
    'historic condition', 
    (
      SELECT 
        jsonb_agg(
          ST_AsGeoJSON(h.*):: jsonb
        ) 
      FROM 
        historic_condition h
    ), 
    'forecast condition', 
    (
      SELECT 
        jsonb_agg(
          ST_AsGeoJSON(f.*):: jsonb
        ) 
      FROM 
        forecast_condition f
    ), 
    'geotechnical inventory', 
    (
      SELECT 
        jsonb_agg(
          ST_AsGeoJSON(g.*):: jsonb
        ) 
      FROM 
        geotechnical_inventory g
    ), 
    'context', 
    (
      SELECT 
        jsonb_agg(
          ST_AsGeoJSON(e.*):: jsonb
        ) 
      FROM 
        environmental_context e
    )
  ) AS geojson_output;
