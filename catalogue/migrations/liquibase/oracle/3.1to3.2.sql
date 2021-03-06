--liquibase formatted sql

--changeset ccaffy:1 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=3;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=2;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';

--changeset ccaffy:2 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
CREATE SEQUENCE FILE_RECYCLE_LOG_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
--rollback DROP SEQUENCE FILE_RECYCLE_LOG_ID_SEQ;

--changeset ccaffy:3 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
CREATE TABLE FILE_RECYCLE_LOG(
  FILE_RECYCLE_LOG_ID        NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_ID_NN NOT NULL,
  VID                        VARCHAR2(100)        CONSTRAINT FILE_RECYCLE_LOG_VID_NN NOT NULL,
  FSEQ                       NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_FSEQ_NN NOT NULL,
  BLOCK_ID                   NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_BID_NN NOT NULL,
  COPY_NB                    NUMERIC(3, 0)           CONSTRAINT FILE_RECYCLE_LOG_COPY_NB_NN NOT NULL,
  TAPE_FILE_CREATION_TIME    NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_TFCT_NN NOT NULL,
  ARCHIVE_FILE_ID            NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_AFI_NN NOT NULL,
  DISK_INSTANCE_NAME         VARCHAR2(100)        CONSTRAINT FILE_RECYCLE_LOG_DIN_NN NOT NULL,
  DISK_FILE_ID               VARCHAR2(100)        CONSTRAINT FILE_RECYCLE_LOG_DFI_NN NOT NULL,
  DISK_FILE_ID_WHEN_DELETED  VARCHAR2(100)        CONSTRAINT FILE_RECYCLE_LOG_DFIWD_NN NOT NULL,
  DISK_FILE_UID              NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_DFU_NN NOT NULL,
  DISK_FILE_GID              NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_DFG_NN NOT NULL,
  SIZE_IN_BYTES              NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_SIB_NN NOT NULL,
  CHECKSUM_BLOB              RAW(200),
  CHECKSUM_ADLER32           NUMERIC(10, 0)          CONSTRAINT FILE_RECYCLE_LOG_CA_NN NOT NULL,
  STORAGE_CLASS_ID           NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_SCI_NN NOT NULL,
  ARCHIVE_FILE_CREATION_TIME NUMERIC(20, 0)          CONSTRAINT FILE_RECYLE_LOG_CT_NN NOT NULL,
  RECONCILIATION_TIME        NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_RT_NN NOT NULL,
  COLLOCATION_HINT           VARCHAR2(100),
  DISK_FILE_PATH             VARCHAR2(2000),
  REASON_LOG                 VARCHAR2(1000)       CONSTRAINT FILE_RECYCLE_LOG_RL_NN NOT NULL,
  RECYCLE_LOG_TIME           NUMERIC(20, 0)          CONSTRAINT FILE_RECYCLE_LOG_RLT_NN NOT NULL,
  CONSTRAINT FILE_RECYCLE_LOG_PK PRIMARY KEY(FILE_RECYCLE_LOG_ID),
  CONSTRAINT FILE_RECYCLE_LOG_VID_FK FOREIGN KEY(VID) REFERENCES TAPE(VID),
  CONSTRAINT FILE_RECYCLE_LOG_SC_FK FOREIGN KEY(STORAGE_CLASS_ID) REFERENCES STORAGE_CLASS(STORAGE_CLASS_ID)
);
--rollback DROP TABLE FILE_RECYCLE_LOG;

--changeset ccaffy:4 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
CREATE INDEX FILE_RECYCLE_LOG_DFI_IDX ON FILE_RECYCLE_LOG(DISK_FILE_ID);
--rollback DROP INDEX FILE_RECYCLE_LOG_DFI_IDX;

--changeset ccaffy:5 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
INSERT INTO FILE_RECYCLE_LOG (
  FILE_RECYCLE_LOG_ID,
  VID,
  FSEQ,
  BLOCK_ID,
  COPY_NB,
  TAPE_FILE_CREATION_TIME,
  ARCHIVE_FILE_ID,
  DISK_INSTANCE_NAME,
  DISK_FILE_ID,
  DISK_FILE_ID_WHEN_DELETED,
  DISK_FILE_UID,
  DISK_FILE_GID,
  SIZE_IN_BYTES,
  CHECKSUM_BLOB,
  CHECKSUM_ADLER32,
  STORAGE_CLASS_ID,
  ARCHIVE_FILE_CREATION_TIME,
  RECONCILIATION_TIME,
  COLLOCATION_HINT,
  REASON_LOG,
  RECYCLE_LOG_TIME
) SELECT
    FILE_RECYCLE_LOG_ID_SEQ.NEXTVAL,
    TAPE_FILE.VID,
    TAPE_FILE.FSEQ,
    TAPE_FILE.BLOCK_ID,
    TAPE_FILE.COPY_NB,
    TAPE_FILE.CREATION_TIME,
    TAPE_FILE.ARCHIVE_FILE_ID,
    ARCHIVE_FILE.DISK_INSTANCE_NAME,
    ARCHIVE_FILE.DISK_FILE_ID,
    ARCHIVE_FILE.DISK_FILE_ID,
    ARCHIVE_FILE.DISK_FILE_UID,
    ARCHIVE_FILE.DISK_FILE_GID,
    ARCHIVE_FILE.SIZE_IN_BYTES,
    ARCHIVE_FILE.CHECKSUM_BLOB,
    ARCHIVE_FILE.CHECKSUM_ADLER32,
    ARCHIVE_FILE.STORAGE_CLASS_ID,
    ARCHIVE_FILE.CREATION_TIME,
    ARCHIVE_FILE.RECONCILIATION_TIME,
    ARCHIVE_FILE.COLLOCATION_HINT,
    'REPACK',
    (cast (systimestamp at time zone 'UTC' as date) - date '1970-01-01') * 86400
  FROM
    TAPE_FILE JOIN
    ARCHIVE_FILE ON TAPE_FILE.ARCHIVE_FILE_ID = ARCHIVE_FILE.ARCHIVE_FILE_ID
  WHERE TAPE_FILE.SUPERSEDED_BY_VID IS NOT NULL;

--changeset ccaffy:6 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
DELETE FROM TAPE_FILE WHERE SUPERSEDED_BY_VID IS NOT NULL;

--changeset ccaffy:7 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
INSERT INTO FILE_RECYCLE_LOG (
  FILE_RECYCLE_LOG_ID,
  VID,
  FSEQ,
  BLOCK_ID,
  COPY_NB,
  TAPE_FILE_CREATION_TIME,
  ARCHIVE_FILE_ID,
  DISK_INSTANCE_NAME,
  DISK_FILE_ID,
  DISK_FILE_ID_WHEN_DELETED,
  DISK_FILE_UID,
  DISK_FILE_GID,
  SIZE_IN_BYTES,
  CHECKSUM_BLOB,
  CHECKSUM_ADLER32,
  STORAGE_CLASS_ID,
  ARCHIVE_FILE_CREATION_TIME,
  RECONCILIATION_TIME,
  COLLOCATION_HINT,
  DISK_FILE_PATH,
  REASON_LOG,
  RECYCLE_LOG_TIME
) SELECT
    FILE_RECYCLE_LOG_ID_SEQ.NEXTVAL,
    TAPE_FILE_RECYCLE_BIN.VID,
    TAPE_FILE_RECYCLE_BIN.FSEQ,
    TAPE_FILE_RECYCLE_BIN.BLOCK_ID,
    TAPE_FILE_RECYCLE_BIN.COPY_NB,
    TAPE_FILE_RECYCLE_BIN.CREATION_TIME,
    TAPE_FILE_RECYCLE_BIN.ARCHIVE_FILE_ID,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_INSTANCE_NAME,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_FILE_ID,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_FILE_ID_WHEN_DELETED,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_FILE_UID,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_FILE_GID,
    ARCHIVE_FILE_RECYCLE_BIN.SIZE_IN_BYTES,
    ARCHIVE_FILE_RECYCLE_BIN.CHECKSUM_BLOB,
    ARCHIVE_FILE_RECYCLE_BIN.CHECKSUM_ADLER32,
    ARCHIVE_FILE_RECYCLE_BIN.STORAGE_CLASS_ID,
    ARCHIVE_FILE_RECYCLE_BIN.CREATION_TIME,
    ARCHIVE_FILE_RECYCLE_BIN.RECONCILIATION_TIME,
    ARCHIVE_FILE_RECYCLE_BIN.COLLOCATION_HINT,
    ARCHIVE_FILE_RECYCLE_BIN.DISK_FILE_PATH,
    'Deleted file imported from the old recycle-bin',
    ARCHIVE_FILE_RECYCLE_BIN.DELETION_TIME
  FROM
    TAPE_FILE_RECYCLE_BIN JOIN
    ARCHIVE_FILE_RECYCLE_BIN ON TAPE_FILE_RECYCLE_BIN.ARCHIVE_FILE_ID = ARCHIVE_FILE_RECYCLE_BIN.ARCHIVE_FILE_ID;

--changeset ccaffy:8 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
TRUNCATE TABLE TAPE_FILE_RECYCLE_BIN;

--changeset ccaffy:9 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
TRUNCATE TABLE ARCHIVE_FILE_RECYCLE_BIN;

--changeset ccaffy:11 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE ADD (
  TAPE_STATE VARCHAR2(100),
  STATE_REASON VARCHAR2(1000),
  STATE_UPDATE_TIME NUMERIC(20, 0),
  STATE_MODIFIED_BY VARCHAR2(100),
  CONSTRAINT TAPE_STATE_CK CHECK(TAPE_STATE IN ('ACTIVE', 'DISABLED', 'BROKEN'))
);

--changeset ccaffy:12 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
CREATE INDEX TAPE_STATE_IDX ON TAPE(TAPE_STATE);

--changeset ccaffy:13 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
UPDATE TAPE
SET TAPE_STATE='ACTIVE',
STATE_UPDATE_TIME=(cast (systimestamp at time zone 'UTC' as date) - date '1970-01-01') * 86400,
STATE_MODIFIED_BY='Migration from CTA 3.1 to 4.0'
WHERE TAPE.IS_DISABLED = '0' AND (TAPE.TAPE_STATE IS NULL OR TAPE.TAPE_STATE <> 'ACTIVE');

--changeset ccaffy:14 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
UPDATE TAPE
SET TAPE_STATE='DISABLED',
STATE_REASON=(CASE WHEN TAPE.USER_COMMENT IS NULL THEN 'Migration from CTA 3.1 to 4.0: tape disabled without comment' ELSE TAPE.USER_COMMENT END),
STATE_UPDATE_TIME=(cast (systimestamp at time zone 'UTC' as date) - date '1970-01-01') * 86400,
STATE_MODIFIED_BY='Migration from CTA 3.1 to 4.0'
WHERE TAPE.IS_DISABLED = '1' AND (TAPE.TAPE_STATE IS NULL OR TAPE.TAPE_STATE != 'DISABLED') AND (TAPE.USER_COMMENT IS NULL OR TAPE.USER_COMMENT NOT LIKE '%- BROKEN -%');

--changeset ccaffy:15 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
UPDATE TAPE
SET TAPE_STATE='BROKEN',
STATE_REASON=TAPE.USER_COMMENT,
STATE_UPDATE_TIME=(cast (systimestamp at time zone 'UTC' as date) - date '1970-01-01') * 86400,
STATE_MODIFIED_BY='Migration from CTA 3.1 to 4.0'
WHERE TAPE.IS_DISABLED = '1' AND (TAPE.TAPE_STATE IS NULL OR TAPE.TAPE_STATE != 'BROKEN') AND TAPE.USER_COMMENT LIKE '%- BROKEN -%';

--changeset ccaffy:16 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE DROP COLUMN IS_ARCHIVED;
ALTER TABLE TAPE DROP COLUMN IS_EXPORTED;

--changeset ccaffy:17 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE DROP CONSTRAINT TAPE_ID_NN;

--changeset ccaffy:18 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE DROP CONSTRAINT TAPE_IRO_NN;

--changeset ccaffy:19 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE VIRTUAL_ORGANIZATION ADD (
  READ_MAX_DRIVES NUMERIC(20,0),
  WRITE_MAX_DRIVES NUMERIC(20,0)
);

--changeset ccaffy:20 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
UPDATE VIRTUAL_ORGANIZATION SET READ_MAX_DRIVES=2 WHERE READ_MAX_DRIVES IS NULL;

--changeset ccaffy:21 failOnError:true dbms:oracle runAlways:true
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"1" SELECT COUNT(*) FROM CTA_CATALOGUE WHERE SCHEMA_VERSION_MAJOR = 3 AND (SCHEMA_VERSION_MINOR = 1 OR SCHEMA_VERSION_MINOR = 2);
UPDATE VIRTUAL_ORGANIZATION SET WRITE_MAX_DRIVES=2 WHERE WRITE_MAX_DRIVES IS NULL;

--changeset ccaffy:22 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE MOUNT_POLICY DROP CONSTRAINT MOUNT_POLICY_MDA_NN;

--changeset ccaffy:23 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"3.1" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=3;
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=2;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=3;
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=1;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=3;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=2;
