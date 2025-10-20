#!/bin/sh

# Habilitar modo ARCHIVELOG y preparar para replicación (GoldenGate / Debezium)
# Usa autenticación del sistema operativo (sqlplus / as sysdba)

ORACLE_SID=prd
export ORACLE_SID

sqlplus / as sysdba <<- EOF
    -- Configurar destino de archivos de recuperación
    ALTER SYSTEM SET db_recovery_file_dest_size = 10G;
    ALTER SYSTEM SET db_recovery_file_dest = '/u01/app/oracle/oradata/recovery_area' SCOPE=SPFILE;

    -- Reiniciar la base para activar modo ARCHIVELOG
    SHUTDOWN IMMEDIATE;
    STARTUP MOUNT;
    ALTER DATABASE ARCHIVELOG;
    ALTER DATABASE OPEN;

    -- Mostrar estado del log archivado
    ARCHIVE LOG LIST;
    EXIT;
EOF


# Enable LogMiner required database features/settings
sqlplus / as sysdba <<- EOF
  ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
  ALTER PROFILE DEFAULT LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED;
  exit;
EOF

# Create LogMiner Tablespaces in CDB and PDB
sqlplus / as sysdba <<- EOF
  -- Mostrar contenedor actual
  SHOW CON_NAME;

  -- Crear tablespace en el PDB1 (necesario si usas DEFAULT TABLESPACE LOGMINER_TBS)
  ALTER SESSION SET CONTAINER=PDB1;
  CREATE TABLESPACE LOGMINER_TBS
    DATAFILE '/u01/app/oracle/oradata/ORCL/PDB1/pdb1_logminer_tbs.dbf'
    SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;

  -- Volver al contenedor raíz (CDB$ROOT)
  ALTER SESSION SET CONTAINER=CDB$ROOT;
  CREATE TABLESPACE LOGMINER_TBS
    DATAFILE '/u01/app/oracle/oradata/ORCL/logminer_tbs.dbf'
    SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;

  -- Confirmar en qué contenedor estás al final
  SHOW CON_NAME;
  EXIT;
EOF


# Create CDB-level user for Debezium
sqlplus / as sysdba <<- EOF
  CREATE USER c##dbzuser IDENTIFIED BY dbz DEFAULT TABLESPACE LOGMINER_TBS QUOTA UNLIMITED ON LOGMINER_TBS CONTAINER=ALL;

  GRANT CREATE SESSION TO c##dbzuser CONTAINER=ALL;
  GRANT SET CONTAINER TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$DATABASE TO c##dbzuser CONTAINER=ALL;
  GRANT FLASHBACK ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT_CATALOG_ROLE TO c##dbzuser CONTAINER=ALL;
  GRANT EXECUTE_CATALOG_ROLE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY TRANSACTION TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY DICTIONARY TO c##dbzuser CONTAINER=ALL;
  GRANT LOGMINING TO c##dbzuser CONTAINER=ALL;

  GRANT CREATE TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT LOCK ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT CREATE SEQUENCE TO c##dbzuser CONTAINER=ALL;

  GRANT EXECUTE ON DBMS_LOGMNR TO c##dbzuser CONTAINER=ALL;
  GRANT EXECUTE ON DBMS_LOGMNR_D TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGMNR_LOGS TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGMNR_CONTENTS TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGFILE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$ARCHIVED_LOG TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON V_\$ARCHIVE_DEST_STATUS TO c##dbzuser CONTAINER=ALL;
  exit;
EOF

# Create application schema/user for Debezium replication
sqlplus chris/chris@//localhost:1521/pdb1.example.com <<- EOF
  CREATE USER debezium IDENTIFIED BY dbz;
  GRANT CONNECT TO debezium;
  GRANT CREATE SESSION TO debezium;
  GRANT CREATE TABLE TO debezium;
  GRANT CREATE SEQUENCE TO debezium;
  ALTER USER debezium QUOTA 100M ON users;
  exit;
EOF
