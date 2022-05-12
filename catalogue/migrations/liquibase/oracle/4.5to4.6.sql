--liquibase formatted sql

--changeset mvelosob:1 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=4;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=6;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';

--changeset mvelosob:2 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE DISK_SYSTEM ADD (DISK_INSTANCE_NAME VARCHAR(100));
UPDATE DISK_SYSTEM SET DISK_INSTANCE_NAME=NULL;
--rollback ALTER TABLE DISK_SYSTEM DROP COLUMN DISK_INSTANCE_NAME

--changeset mvelosob:3 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE DISK_SYSTEM ADD (DISK_INSTANCE_SPACE_NAME VARCHAR(100));
UPDATE DISK_SYSTEM SET DISK_INSTANCE_SPACE_NAME=NULL;
--rollback ALTER TABLE DISK_SYSTEM DROP COLUMN DISK_INSTANCE_SPACE_NAME

--changeset mvelosob:4 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE DRIVE_STATE ADD (RESERVATION_SESSION_ID NUMERIC(20, 0));
UPDATE DRIVE_STATE SET RESERVATION_SESSION_ID=0;
--rollback ALTER TABLE DRIVE_STATE DROP COLUMN RESERVATION_SESSION_ID

--changeset mvelosob:5 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE DRIVE_STATE DROP CONSTRAINT DRIVE_DSN_NN;
ALTER TABLE DRIVE_STATE DROP CONSTRAINT DRIVE_RB_NN;
--rollback ALTER TABLE DRIVE_STATE MODIFY DISK_SYSTEM_NAME VARCHAR2(100) CONSTRAINT DRIVE_STATE_DSN_NN NOT NULL;
--rollback ALTER TABLE DRIVE_STATE MODIFY RESERVED_BYTES NUMERIC(20, 0) CONSTRAINT DRIVE_STATE_RB_NN NOT NULL;

--changeset mvelosob:6 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE VIRTUAL_ORGANIZATION ADD (DISK_INSTANCE_NAME VARCHAR2(100));
UPDATE VIRTUAL_ORGANIZATION SET DISK_INSTANCE_NAME=NULL;
--rollback ALTER TABLE VIRTUAL_ORGANIZATION DROP COLUMN DISK_INSTANCE_NAME

--changeset mvelosob:7 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.5" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=4;
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=6;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=4;
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=5;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=4;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=6;
