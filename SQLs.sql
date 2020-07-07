-- Selecting both the_geom and the_geom_webmercator columns -> data view

SELECT the_geom, the_geom_webmercator 
FROM worldcities


-- Using PostGIS to display both columns in readable format and to display the coordiantes -> data view

SELECT st_astext(the_geom) as g_text, st_astext(the_geom_webmercator) as gWM_text
FROM worldcities


-- Displaying the results spatially on the map using the_geom_webmercator and filtered by country Egypt
-- This is a non-spatial query

SELECT cartodb_id, the_geom_webmercator
FROM worldcities
WHERE country = 'Egypt'


-- A spatial query that buffers points by 1 degree or 111 km to return polygons.
-- Since the_geom column was used, the results in CartoDB map do not show up. 
-- But still you can export the results as a new PostGIS table.

SELECT st_buffer(the_geom, 1)
FROM worldcities
where country = 'Egypt'


-- The trick to display the previous spatial query result on the map by transforming the coordinate system to web mercator.

SELECT cartodb_id, st_transform(st_buffer(the_geom, 1),3857) as the_geom_webmercator
FROM worldcities
where country = 'Egypt'
