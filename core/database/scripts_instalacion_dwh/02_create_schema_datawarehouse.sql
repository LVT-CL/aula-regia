-- Create schema 'datawarehouse'
CREATE SCHEMA datawarehouse AUTHORIZATION postgres;
CREATE SCHEMA staging AUTHORIZATION postgres;

-- Verify schema creation
SELECT schema_name, schema_owner
FROM information_schema.schemata
WHERE schema_name = 'datawarehouse';