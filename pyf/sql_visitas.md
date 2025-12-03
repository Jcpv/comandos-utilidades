
# 1. Vistas o descargas por artículo
SELECT submission_id, SUM(metric) AS total_vistas
FROM metrics
WHERE metric_type = 'ojs::counter'
GROUP BY submission_id
ORDER BY total_vistas DESC;


# 2. Tendencia mensual de accesos
SELECT month, SUM(metric) AS total_vistas
FROM metrics
WHERE metric_type = 'ojs::counter'
GROUP BY month
ORDER BY month;

#3. Distribución geográfica
SELECT country_id, SUM(metric) AS total_vistas
FROM metrics
WHERE metric_type = 'ojs::counter'
GROUP BY country_id
ORDER BY total_vistas DESC;


4. Comparación por tipo de archivo
SELECT file_type, SUM(metric) AS total_descargas
FROM metrics
WHERE metric_type = 'ojs::counter'
GROUP BY file_type;