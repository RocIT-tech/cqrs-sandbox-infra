-- SELECT SPECIAL CHARGES PER RESIDENCES
SELECT
    r.id          AS residence_id,
    r.total_parts AS residence_total_parts,
    JSONB_OBJECT_AGG(
        sc.id, JSONB_BUILD_OBJECT(
        'special_charges_id', sc.id,
        'special_charges_name', sc.name,
        'special_charges_total_parts', sc.total_parts
        )
        )         AS "special charges"
    FROM
        accommodation.accommodation a
        INNER JOIN accommodation.residence r
                   ON a.residence_id = r.id
        INNER JOIN accommodation.accommodation_special_charges a2
                   ON a.id = a2.accommodation_id
        INNER JOIN accommodation.special_charges sc
                   ON a2.special_charges_id = sc.id
    WHERE
            r.id = '1'
    GROUP BY
        r.id;

-- VERIFY TOTAL OF PROPORTIONAL PARTS FOR SPECIAL CHARGES
SELECT
    r.id                       AS residence_id,
    sc.total_parts,
    SUM(a2.proportional_parts) AS sum_proportional_parts
    FROM
        accommodation.accommodation_special_charges a2
        INNER JOIN accommodation.special_charges sc
                   ON a2.special_charges_id = sc.id
        INNER JOIN accommodation.accommodation a
                   ON a2.accommodation_id = a.id
        INNER JOIN accommodation.residence r
                   ON a.residence_id = r.id
    GROUP BY
        r.id,
        sc.id;

-- VERIFY TOTAL OF PROPORTIONAL PARTS FOR GENERAL CHARGES
SELECT
    r.id                      AS residence_id,
    r.total_parts,
    SUM(a.proportional_parts) AS sum_proportional_parts
    FROM
        accommodation.accommodation a
        INNER JOIN accommodation.residence r
                   ON a.residence_id = r.id
    GROUP BY
        r.id;

-- LIST TENANTS AND ACCOMMODATIONS
SELECT
    a_a.residence_id                              AS "residence",
    ARRAY_TO_STRING(ARRAY_AGG(a_t.name), ', ')    AS "nom des coproprietaires",
    ARRAY_TO_STRING(ARRAY_AGG(a_t.address), ', ') AS "adresse",
    a_a.number                                    AS "numero de lot",
    a_a.usage                                     AS "usage",
    a_a.proportional_parts                        AS "tantiemes generaux",
    JSONB_OBJECT_AGG(
        a_sc.id, JSONB_BUILD_OBJECT(
        'id', a_sc.id,
        'proportional_parts', a_asc.proportional_parts
        )
        )                                         AS "special charges"
    FROM
        accommodation.accommodation a_a
        LEFT JOIN accommodation.accommodation_special_charges a_asc
                  ON a_a.id = a_asc.accommodation_id
        LEFT JOIN accommodation.special_charges a_sc
                  ON a_asc.special_charges_id = a_sc.id
        LEFT JOIN accommodation.tenant_accommodation a_ta
                  ON a_a.id = a_ta.accommodation_id
        LEFT JOIN accommodation.tenant a_t
                  ON a_ta.owner_id = a_t.id
    WHERE
        a_a.residence_id = '1'
    GROUP BY
        a_a.id
    ORDER BY
        "residence"     ASC,
        "numero de lot" ASC
;

