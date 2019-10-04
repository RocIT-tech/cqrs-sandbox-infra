-- EXTENSIONS
CREATE EXTENSION hstore;

-- ===============
-- SCHEMA IDENTITY
-- ===============
CREATE SCHEMA identity;

-- CREATE TABLES
CREATE TABLE identity.user
(
    id     VARCHAR(36) NOT NULL
        CONSTRAINT identity_user_pk
            PRIMARY KEY,
    idp_id VARCHAR(50) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS identity_user_idp_id_uindex
    ON identity.user (idp_id);

-- ====================
-- SCHEMA ACCOMMODATION
-- ====================
CREATE SCHEMA accommodation;

-- CREATE FUNCTIONS
CREATE OR REPLACE FUNCTION
    accommodation.owner_in_residence(
                                        p_residence_id VARCHAR(36),
                                        p_id           VARCHAR(36)
)
    RETURNS BOOLEAN AS
$$
BEGIN
    IF p_id IS NULL OR p_id IN (
                   SELECT
                       a_ta.owner_id
                       FROM
                           accommodation.tenant_accommodation a_ta
                           INNER JOIN accommodation.accommodation a_a
                                      ON a_ta.accommodation_id = a_a.id
                           INNER JOIN accommodation.residence a_r
                                      ON a_a.residence_id = a_r.id
                       WHERE
                           a_r.id = p_residence_id
               )
    THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE PLpgSQL;

-- CREATE TABLES
CREATE TABLE accommodation.tenant
(
    id               VARCHAR(36)  NOT NULL
        CONSTRAINT accommodation_tenant_pk
            PRIMARY KEY,
    name             VARCHAR(255) NOT NULL,
    address          VARCHAR(255) NOT NULL,
    identity_user_id VARCHAR(50)
        CONSTRAINT accommodation_tenant_identity_user_id_fk
            REFERENCES identity.user
            ON DELETE SET NULL
);

CREATE TABLE accommodation.residence
(
    id              VARCHAR(36)  NOT NULL
        CONSTRAINT accommodation_residence_pk
            PRIMARY KEY,
    address         VARCHAR(255) NOT NULL,
    owner_tenant_id VARCHAR(36)
        CONSTRAINT accommodation_residence_tenant_id_fk
            REFERENCES accommodation.tenant
            ON DELETE SET NULL,
    name            VARCHAR(255) NOT NULL,
    total_parts     INTEGER      NOT NULL,
    CONSTRAINT owner_in_residence CHECK (accommodation.owner_in_residence(id, owner_tenant_id))
);

CREATE TABLE accommodation.accommodation
(
    id                 VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_accommodation_pk
            PRIMARY KEY,
    number             INTEGER     NOT NULL,
    usage              VARCHAR(50) NOT NULL,
    proportional_parts INTEGER     NOT NULL,
    residence_id       VARCHAR(36)
        CONSTRAINT accommodation_accommodation_residence_id_fk
            REFERENCES accommodation.residence
            ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS accommodation_accommodation_residence_id_number_uindex
    ON accommodation.accommodation (residence_id, number);

CREATE TABLE accommodation.tenant_accommodation
(
    owner_id         VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_tenant_accommodation_tenant_id_fk
            REFERENCES accommodation.tenant
            ON DELETE CASCADE,
    accommodation_id VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_tenant_accommodation_accommodation_id_fk
            REFERENCES accommodation.accommodation
            ON DELETE CASCADE,
    CONSTRAINT accommodation_tenant_lots_pk
        PRIMARY KEY (owner_id, accommodation_id)
);

CREATE TABLE accommodation.special_charges
(
    id          VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_special_charges_pk
            PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    total_parts INTEGER     NOT NULL
);

CREATE TABLE accommodation.accommodation_special_charges
(
    accommodation_id   VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_accommodation_special_charges_accommodation_id_fk
            REFERENCES accommodation.accommodation
            ON DELETE CASCADE,
    special_charges_id VARCHAR(36) NOT NULL
        CONSTRAINT accommodation_accommodation_special_charges_special_charges_id_fk
            REFERENCES accommodation.special_charges
            ON DELETE CASCADE,
    proportional_parts INTEGER     NOT NULL,
    CONSTRAINT accommodation_accommodation_special_charges_pk
        PRIMARY KEY (accommodation_id, special_charges_id)
);

-- CREATE VIEWS
CREATE OR REPLACE VIEW accommodation.view_list_special_charges_per_residence AS
SELECT
    a_r.id                        AS residence_id,
    a_sc.id                       AS special_charges_id,
    SUM(a_asc.proportional_parts) AS sum_parts,
    a_sc.total_parts              AS total_parts
    FROM
        accommodation.accommodation_special_charges a_asc
        INNER JOIN accommodation.special_charges a_sc
                   ON a_asc.special_charges_id = a_sc.id
        INNER JOIN accommodation.accommodation a_a
                   ON a_asc.accommodation_id = a_a.id
        INNER JOIN accommodation.residence a_r
                   ON a_a.residence_id = a_r.id
    GROUP BY
        a_r.id,
        a_sc.id
;

CREATE OR REPLACE VIEW accommodation.view_list_special_charges AS
SELECT
    a_r.id                      AS residence_id,
    a_r.total_parts             AS residence_total_parts,
    SUM(a_a.proportional_parts) AS residence_sum_parts,
    JSONB_OBJECT_AGG(
        a_sc.id, JSONB_BUILD_OBJECT(
        'special_charges_id', a_sc.id,
        'special_charges_name', a_sc.name,
        'special_charges_total_parts', a_sc.total_parts,
        'special_charges_sum_parts', a_vlscpr.sum_parts
        )
        )                       AS special_charges
    FROM
        accommodation.accommodation a_a
        INNER JOIN accommodation.residence a_r
                   ON a_a.residence_id = a_r.id
        INNER JOIN accommodation.accommodation_special_charges a_asc
                   ON a_a.id = a_asc.accommodation_id
        INNER JOIN accommodation.special_charges a_sc
                   ON a_asc.special_charges_id = a_sc.id
        INNER JOIN accommodation.view_list_special_charges_per_residence a_vlscpr
                   ON a_vlscpr.special_charges_id = a_sc.id AND a_vlscpr.residence_id = a_r.id
    GROUP BY
        a_r.id;
