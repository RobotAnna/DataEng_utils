-- -------------------------------------------------------------------------------
-- Retrieve DDL
--
-- It's easier to use INFORMATION_SCHEMA, but this may remove line endings.
-- Calling function get_ddl preserves formatting.
--
-- Author: Nerrida Dempster
-- Date: 08/09/2021
-- -------------------------------------------------------------------------------

-- Generates the script to extract DDL
SELECT
'select \''||ttype||'\', \''||tname||'\', get_ddl(\''||ttype||'\',
\''||table_catalog||'.'||table_schema||'.'||tname||'\') union all'
FROM (
SELECT
CASE
WHEN table_type = 'BASE TABLE' THEN 'table'
WHEN table_type = 'VIEW' THEN 'view'
ELSE 'error'
END AS ttype
, table_catalog
, table_schema
, table_name AS tname
FROM database_name.INFORMATION_SCHEMA.TABLES
WHERE table_schema IN ('schema_name')
ORDER BY table_type, table_name
)
;


-- paste results to Notepad, then copy/paste into the worksheet
select 'table', 'table_name', get_ddl('table', 'database_name.schema_name.table_name') union all
select 'table', 'table_name', get_ddl('table', 'database_name.schema_name.table_name')
;

select 'view', 'view_name', get_ddl('view', 'database_name.schema_name.view_name') union all
select 'view', 'view_name', get_ddl('view', 'database_name.schema_name.view_name')
;

