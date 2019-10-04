-- ===============
-- SCHEMA ACCOMMODATION
-- ===============

-- ===============
-- VIEWS ACCOMMODATION
-- ===============
DROP VIEW IF EXISTS accommodation.view_list_special_charges;
DROP VIEW IF EXISTS accommodation.view_list_special_charges_per_residence;

-- ===============
-- TABLES ACCOMMODATION
-- ===============
DROP TABLE IF EXISTS accommodation.accommodation_special_charges;
DROP TABLE IF EXISTS accommodation.special_charges;
DROP TABLE IF EXISTS accommodation.tenant_accommodation;
DROP TABLE IF EXISTS accommodation.accommodation;
DROP TABLE IF EXISTS accommodation.residence;
DROP TABLE IF EXISTS accommodation.tenant;

-- ===============
-- FUNCTIONS ACCOMMODATION
-- ===============
DROP FUNCTION IF EXISTS accommodation.owner_in_residence;

DROP SCHEMA IF EXISTS accommodation;

-- ===============
-- SCHEMA IDENTITY
-- ===============

-- ===============
-- TABLES IDENTITY
-- ===============
DROP TABLE IF EXISTS identity."user";

DROP SCHEMA IF EXISTS identity;

-- ===============
-- EXTENSIONS
-- ===============
DROP EXTENSION IF EXISTS hstore;
