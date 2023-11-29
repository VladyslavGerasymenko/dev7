SELECT ФИО, Email, Адреса, Квартира, Площа
FROM myosbb.учасники_осбб AS OSBB
JOIN myosbb.мешканці AS P ON OSBB.ID = P.Учасник_ИД
JOIN myosbb.квартири AS KV ON P.квартира_ИД = KV.ID
JOIN myosbb.будинки_до_квартир AS BDKV ON KV.ID = BDKV.квартири_ид
JOIN myosbb.будинки AS bud ON BDKV.будинки_ИД = bud.id
WHERE NOT P.вїзд_на_жк
AND OSBB.ID IN (
    SELECT OSBB.ID
    FROM myosbb.учасники_осбб AS OSBB
    JOIN myosbb.мешканці AS P ON OSBB.ID = P.Учасник_ИД
    JOIN myosbb.квартири AS KV ON P.квартира_ИД = KV.ID    
    GROUP BY OSBB.ID
    HAVING COUNT(KV.ID) < 2
)
GROUP BY ФИО, Email, Адреса, Квартира, Площа
ORDER BY ФИО DESC;
