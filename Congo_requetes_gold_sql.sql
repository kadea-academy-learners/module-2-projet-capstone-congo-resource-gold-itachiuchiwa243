MISSION A

1. Nombre d'engins par site

SELECT 
    s.nom AS site,
    s.province,
    COUNT(e.id_engin) AS nombre_engins
FROM sites s
LEFT JOIN engins e ON s.id_site = e.id_site
GROUP BY s.nom, s.province
ORDER BY s.nom;


2. Jours où la production est nulle

SELECT 
    p.date_prod,
    s.nom AS site,
    p.type_minerai,
    p.tonnage_brut
FROM production p
JOIN sites s ON p.id_site = s.id_site
WHERE p.tonnage_brut = 0;


3. Liste des engins avec leur site

SELECT 
    e.id_engin,
    e.type AS type_engin,
    s.nom AS site,
    s.province
FROM engins e
JOIN sites s ON e.id_site = s.id_site
ORDER BY e.id_engin;


MISSION B

1. Production totale par province et type de minerai
SELECT 
    s.province,
    p.type_minerai,
    SUM(p.tonnage_brut) AS production_totale
FROM production p
JOIN sites s ON p.id_site = s.id_site
GROUP BY s.province, p.type_minerai
ORDER BY s.province, p.type_minerai;


2. Calcul du contenu fin
SELECT 
    s.nom AS site,
    p.type_minerai,
    SUM(p.tonnage_brut * p.teneur / 100) AS contenu_fin
FROM production p
JOIN sites s ON p.id_site = s.id_site
GROUP BY s.nom, p.type_minerai
ORDER BY contenu_fin DESC;


3. Chiffre d'affaires total par site
SELECT 
    s.nom AS site,
    SUM(e.tonnage_vendu * e.prix_unitaire_usd) AS chiffre_affaires_total
FROM exportations e
JOIN sites s ON e.id_site = s.id_site
GROUP BY s.nom
ORDER BY chiffre_affaires_total DESC;


4. Sites dont la teneur moyenne est inférieure à 2.5 %
SELECT 
    s.nom AS site,
    ROUND(AVG(p.teneur)::numeric, 2) AS teneur_moyenne
FROM production p
JOIN sites s ON p.id_site = s.id_site
GROUP BY s.nom
HAVING AVG(p.teneur) < 2.5
ORDER BY teneur_moyenne ASC;