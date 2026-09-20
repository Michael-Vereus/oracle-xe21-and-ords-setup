CREATE USER devuser IDENTIFIED BY Dev_1234 QUOTA UNLIMITED ON USERS;
GRANT CONNECT, RESOURCE TO devuser;
GRANT INHERIT PRIVILEGES ON USER devuser TO ORDS_METADATA;

CONNECT devuser/Dev_1234@localhost:1521/XEPDB1

BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => 'DEVUSER',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'devuser',
    p_auto_rest_auth      => FALSE
  );
  COMMIT;
END;
/
EXIT;