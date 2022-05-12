--liquibase formatted sql

--changeset mvelosob:1 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--!!!THIS FALSE PRECONDITION IS HERE TO BLOCK AN UPGRADE WHILE THE DEVELOPMENT OF THE NEW CATALOGUE VERSION IS BEING DEVELOPED!!!
UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=10;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=0;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';

--changeset mvelosob:2 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE ADD (VERIFICATION_STATUS VARCHAR2(1000));
ALTER TABLE TAPE ADD (LABEL_FORMAT CHAR(1));
--rollback ALTER TABLE TAPE DROP COLUMN VERIFICATION_STATUS;
--rollback ALTER TABLE TAPE DROP COLUMN LABEL_FORMAT;

--changeset mdavis:3 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE VIRTUAL_ORGANIZATION DROP CONSTRAINT VIRTUAL_ORGANIZATION_VON_UN;
ALTER TABLE STORAGE_CLASS DROP CONSTRAINT STORAGE_CLASS_SCN_UN;
ALTER TABLE TAPE_POOL DROP CONSTRAINT TAPE_POOL_TPN_UN;
ALTER TABLE MEDIA_TYPE DROP CONSTRAINT MEDIA_TYPE_MTN_UN;
ALTER TABLE LOGICAL_LIBRARY DROP CONSTRAINT LOGICAL_LIBRARY_LLN_UN;
CREATE UNIQUE INDEX ADMIN_USER_AUN_UN_IDX ON ADMIN_USER(LOWER(ADMIN_USER_NAME));
CREATE UNIQUE INDEX DISK_SYSTEM_DSN_UN_IDX ON DISK_SYSTEM(LOWER(DISK_SYSTEM_NAME));
CREATE UNIQUE INDEX DISK_INSTANCE_DIN_UN_IDX ON DISK_INSTANCE(LOWER(DISK_INSTANCE_NAME));
CREATE UNIQUE INDEX DISK_INSTNCE_SPCE_DISN_UN_IDX ON DISK_INSTANCE_SPACE(LOWER(DISK_INSTANCE_SPACE_NAME));
CREATE INDEX DISK_SYSTEM_DIN_DISN_IDX ON DISK_SYSTEM(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME);
CREATE UNIQUE INDEX VIRTUAL_ORG_VON_UN_IDX ON VIRTUAL_ORGANIZATION(LOWER(VIRTUAL_ORGANIZATION_NAME));
CREATE UNIQUE INDEX STORAGE_CLASS_SCN_UN_IDX ON STORAGE_CLASS(LOWER(STORAGE_CLASS_NAME));
CREATE INDEX STORAGE_CLASS_VOI_IDX ON STORAGE_CLASS(VIRTUAL_ORGANIZATION_ID);
CREATE UNIQUE INDEX TAPE_POOL_TPN_UN_IDX ON TAPE_POOL(LOWER(TAPE_POOL_NAME));
CREATE INDEX TAPE_POOL_VOI_IDX ON TAPE_POOL(VIRTUAL_ORGANIZATION_ID);
CREATE UNIQUE INDEX MEDIA_TYPE_MTN_UN_IDX ON MEDIA_TYPE(LOWER(MEDIA_TYPE_NAME));
CREATE UNIQUE INDEX LOGICAL_LIBRARY_LLN_UN_IDX ON LOGICAL_LIBRARY(LOWER(LOGICAL_LIBRARY_NAME));
CREATE UNIQUE INDEX TAPE_VID_UN_IDX ON TAPE(LOWER(VID));
CREATE INDEX TAPE_LLI_IDX ON TAPE(LOGICAL_LIBRARY_ID);
CREATE INDEX TAPE_MTI_IDX ON TAPE(MEDIA_TYPE_ID);
CREATE UNIQUE INDEX MOUNT_POLICY_MPN_UN_IDX ON MOUNT_POLICY(LOWER(MOUNT_POLICY_NAME));
CREATE INDEX REQ_ACT_MNT_RULE_MPN_IDX ON REQUESTER_ACTIVITY_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX REQ_MNT_RULE_MPN_IDX ON REQUESTER_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX REQ_GRP_MNT_RULE_MPN_IDX ON REQUESTER_GROUP_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX ARCHIVE_FILE_SCI_IDX ON ARCHIVE_FILE(STORAGE_CLASS_ID);
CREATE INDEX FILE_RECYCLE_LOG_SCD_IDX ON FILE_RECYCLE_LOG(STORAGE_CLASS_ID);
CREATE INDEX FILE_RECYCLE_LOG_VID_IDX ON FILE_RECYCLE_LOG(VID);
CREATE UNIQUE INDEX DRIVE_STATE_DN_UN_IDX ON DRIVE_STATE(LOWER(DRIVE_NAME));
--rollback DROP INDEX ADMIN_USER_AUN_UN_IDX;
--rollback DROP INDEX DISK_SYSTEM_DSN_UN_IDX;
--rollback DROP INDEX DISK_INSTANCE_DIN_UN_IDX;
--rollback DROP INDEX DISK_INSTNCE_SPCE_DISN_UN_IDX;
--rollback DROP INDEX DISK_SYSTEM_DIN_DISN_IDX;
--rollback DROP INDEX VIRTUAL_ORG_VON_UN_IDX;
--rollback DROP INDEX STORAGE_CLASS_SCN_UN_IDX;
--rollback DROP INDEX STORAGE_CLASS_VOI_IDX;
--rollback DROP INDEX TAPE_POOL_TPN_UN_IDX;
--rollback DROP INDEX TAPE_POOL_VOI_IDX;
--rollback DROP INDEX MEDIA_TYPE_MTN_UN_IDX;
--rollback DROP INDEX LOGICAL_LIBRARY_LLN_UN_IDX;
--rollback DROP INDEX TAPE_VID_UN_IDX;
--rollback DROP INDEX TAPE_LLI_IDX;
--rollback DROP INDEX TAPE_MTI_IDX;
--rollback DROP INDEX MOUNT_POLICY_MPN_UN_IDX;
--rollback DROP INDEX REQ_ACT_MNT_RULE_MPN_IDX;
--rollback DROP INDEX REQ_MNT_RULE_MPN_IDX;
--rollback DROP INDEX REQ_GRP_MNT_RULE_MPN_IDX;
--rollback DROP INDEX ARCHIVE_FILE_SCI_IDX;
--rollback DROP INDEX FILE_RECYCLE_LOG_SCD_IDX;
--rollback DROP INDEX FILE_RECYCLE_LOG_VID_IDX;
--rollback DROP INDEX DRIVE_STATE_DN_UN_IDX;
--rollback ALTER TABLE VIRTUAL_ORGANIZATION ADD CONSTRAINT VIRTUAL_ORGANIZATION_VON_UN UNIQUE(VIRTUAL_ORGANIZATION_NAME);
--rollback ALTER TABLE STORAGE_CLASS ADD CONSTRAINT STORAGE_CLASS_SCN_UN UNIQUE(STORAGE_CLASS_NAME);
--rollback ALTER TABLE TAPE_POOL ADD CONSTRAINT TAPE_POOL_TPN_UN UNIQUE(TAPE_POOL_NAME);
--rollback ALTER TABLE MEDIA_TYPE ADD CONSTRAINT MEDIA_TYPE_MTN_UN UNIQUE(MEDIA_TYPE_NAME);
--rollback ALTER TABLE LOGICAL_LIBRARY ADD CONSTRAINT LOGICAL_LIBRARY_LLN_UN UNIQUE(LOGICAL_LIBRARY_NAME);

--changeset mdavis:5 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE TAPE DROP CONSTRAINT TAPE_STATE_CK;
ALTER TABLE TAPE ADD CONSTRAINT TAPE_STATE_CK CHECK(TAPE_STATE IN ('ACTIVE', 'REPACKING', 'DISABLED', 'BROKEN')) ENABLE NOVALIDATE;
--rollback ALTER TABLE TAPE DROP CONSTRAINT TAPE_STATE_CK;
--rollback ALTER TABLE TAPE ADD CONSTRAINT TAPE_STATE_CK CHECK(TAPE_STATE IN ('ACTIVE', 'DISABLED', 'BROKEN'));

--changeset mvelosob:6 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE LOGICAL_LIBRARY ADD (DISABLED_REASON VARCHAR2(1000));
--rollback ALTER TABLE LOGICAL_LIBRARY DROP COLUMN DISABLED_REASON;

--changeset mvelosob:7 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--precondition-sql-check expectedResult:"0" SELECT COUNT(*) FROM VIRTUAL_ORGANIZATION WHERE DISK_INSTANCE_NAME NOT IN (SELECT DISK_INSTANCE_NAME FROM DISK_INSTANCE);
ALTER TABLE VIRTUAL_ORGANIZATION ADD CONSTRAINT VIRTUAL_ORGANIZATION_DIN_NN CHECK (DISK_INSTANCE_NAME IS NOT NULL);
ALTER TABLE VIRTUAL_ORGANIZATION ADD CONSTRAINT VIRTUAL_ORGANIZATION_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME);
CREATE INDEX VIRTUAL_ORG_DIN_IDX ON VIRTUAL_ORGANIZATION(DISK_INSTANCE_NAME);
--rollback ALTER TABLE VIRTUAL_ORGANIZATION DROP CONSTRAINT VIRTUAL_ORGANIZATION_DIN_NN;
--rollback ALTER TABLE VIRTUAL_ORGANIZATION DROP CONSTRAINT VIRTUAL_ORGANIZATION_DIN_FK;
--rollback DROP INDEX VIRTUAL_ORG_DIN_IDX;

--changeset mvelosob:8 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM REQUESTER_ACTIVITY_MOUNT_RULE WHERE DISK_INSTANCE_NAME NOT IN (SELECT DISK_INSTANCE_NAME FROM DISK_INSTANCE);
ALTER TABLE REQUESTER_ACTIVITY_MOUNT_RULE ADD CONSTRAINT RQSTER_ACT_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME);
CREATE INDEX REQ_ACT_MNT_RULE_DIN_IDX ON REQUESTER_ACTIVITY_MOUNT_RULE(DISK_INSTANCE_NAME);
--rollback ALTER TABLE REQUESTER_ACTIVITY_MOUNT_RULE DROP CONSTRAINT RQSTER_ACT_RULE_DIN_FK;
--rollback DROP INDEX REQ_ACT_MNT_RULE_DIN_IDX;

--changeset mvelosob:9 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM REQUESTER_MOUNT_RULE WHERE DISK_INSTANCE_NAME NOT IN (SELECT DISK_INSTANCE_NAME FROM DISK_INSTANCE);
ALTER TABLE REQUESTER_MOUNT_RULE ADD CONSTRAINT RQSTER_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME);
CREATE INDEX REQ_MNT_RULE_DIN_IDX ON REQUESTER_MOUNT_RULE(DISK_INSTANCE_NAME);
--rollback ALTER TABLE REQUESTER_MOUNT_RULE DROP CONSTRAINT RQSTER_RULE_DIN_FK;
--rollback DROP INDEX REQ_MNT_RULE_DIN_IDX;

--changeset mvelosob:10 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM REQUESTER_GROUP_MOUNT_RULE WHERE DISK_INSTANCE_NAME NOT IN (SELECT DISK_INSTANCE_NAME FROM DISK_INSTANCE);
ALTER TABLE REQUESTER_GROUP_MOUNT_RULE ADD CONSTRAINT RQSTER_GRP_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME);
CREATE INDEX REQ_GRP_MNT_RULE_DIN_IDX ON REQUESTER_GROUP_MOUNT_RULE(DISK_INSTANCE_NAME);
--rollback ALTER TABLE REQUESTER_GROUP_MOUNT_RULE DROP CONSTRAINT RQSTER_GRP_RULE_DIN_FK;
--rollback DROP INDEX REQ_GRP_MNT_RULE_DIN_IDX;

--changeset mvelosob:11 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM ARCHIVE_FILE WHERE DISK_INSTANCE_NAME NOT IN (SELECT DISK_INSTANCE_NAME FROM DISK_INSTANCE);
ALTER TABLE ARCHIVE_FILE ADD CONSTRAINT ARCHIVE_FILE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME);
--rollback ALTER TABLE ARCHIVE_FILE DROP CONSTRAINT ARCHIVE_FILE_DIN_FK;

--changeset mvelosob:12 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
ALTER TABLE DISK_SYSTEM DROP CONSTRAINT DISK_SYSTEM_FSQU_NN;
ALTER TABLE DISK_SYSTEM DROP CONSTRAINT DISK_SYSTEM_RI_NN;
ALTER TABLE DISK_SYSTEM ADD CONSTRAINT DISK_SYSTEM_DIN_NN CHECK (DISK_INSTANCE_NAME IS NOT NULL);
ALTER TABLE DISK_SYSTEM ADD CONSTRAINT DISK_SYSTEM_DISN_NN CHECK (DISK_INSTANCE_SPACE_NAME IS NOT NULL);
ALTER TABLE DISK_SYSTEM ADD CONSTRAINT DISK_SYSTEM_DIN_DISN_FK FOREIGN KEY(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME) REFERENCES DISK_INSTANCE_SPACE(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME);
--rollback ALTER TABLE DISK_SYSTEM ADD CONSTRAINT DISK_SYSTEM_FSQU_NN CHECK (FREE_SPACE_QUERY_URL IS NOT NULL);
--rollback ALTER TABLE DISK_SYSTEM ADD CONSTRAINT DISK_SYSTEM_RI_NN CHECK (REFRESH_INTERVAL IS NOT NULL);
--rollback ALTER TABLE DISK_SYSTEM DROP CONSTRAINT DISK_SYSTEM_DIN_NN;
--rollback ALTER TABLE DISK_SYSTEM DROP CONSTRAINT DISK_SYSTEM_DISN_NN;
--rollback ALTER TABLE DISK_SYSTEM DROP CONSTRAINT DISK_SYSTEM_DIN_DISN_FK;


--changeset mdavis:4 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
DROP TABLE TAPE_DRIVE;
--rollback CREATE TABLE TAPE_DRIVE(
--rollback   DRIVE_NAME                  VARCHAR2(100)   CONSTRAINT DRIVE_STATE_DN_NN NOT NULL,
--rollback   HOST                        VARCHAR2(100)   CONSTRAINT DRIVE_STATE_H_NN  NOT NULL,
--rollback   LOGICAL_LIBRARY             VARCHAR2(100)   CONSTRAINT DRIVE_STATE_LL_NN NOT NULL,
--rollback   SESSION_ID                  NUMERIC(20, 0),
--rollback   BYTES_TRANSFERED_IN_SESSION NUMERIC(20, 0),
--rollback   FILES_TRANSFERED_IN_SESSION NUMERIC(20, 0),
--rollback   LATEST_BANDWIDTH            VARCHAR2(100),
--rollback   SESSION_START_TIME          NUMERIC(20, 0),
--rollback   MOUNT_START_TIME            NUMERIC(20, 0),
--rollback   TRANSFER_START_TIME         NUMERIC(20, 0),
--rollback   UNLOAD_START_TIME           NUMERIC(20, 0),
--rollback   UNMOUNT_START_TIME          NUMERIC(20, 0),
--rollback   DRAINING_START_TIME         NUMERIC(20, 0),
--rollback   DOWN_OR_UP_START_TIME       NUMERIC(20, 0),
--rollback   PROBE_START_TIME            NUMERIC(20, 0),
--rollback   CLEANUP_START_TIME          NUMERIC(20, 0),
--rollback   START_START_TIME            NUMERIC(20, 0),
--rollback   SHUTDOWN_TIME               NUMERIC(20, 0),
--rollback   MOUNT_TYPE                  NUMERIC(10, 0)  CONSTRAINT DRIVE_STATE_MT_NN NOT NULL,
--rollback   DRIVE_STATUS                VARCHAR2(100)   DEFAULT 'UNKNOWN' CONSTRAINT DRIVE_STATE_DS_NN NOT NULL,
--rollback   DESIRED_UP                  CHAR(1)         DEFAULT '0' CONSTRAINT DRIVE_STATE_DU_NN  NOT NULL,
--rollback   DESIRED_FORCE_DOWN          CHAR(1)         DEFAULT '0' CONSTRAINT DRIVE_STATE_DFD_NN NOT NULL,
--rollback   REASON_UP_DOWN              VARCHAR2(1000),
--rollback   CURRENT_VID                 VARCHAR2(100),
--rollback   CTA_VERSION                 VARCHAR2(100),
--rollback   CURRENT_PRIORITY            NUMERIC(20, 0),
--rollback   CURRENT_ACTIVITY            VARCHAR2(100),
--rollback   CURRENT_ACTIVITY_WEIGHT     VARCHAR2(100),
--rollback   CURRENT_TAPE_POOL           VARCHAR2(100),
--rollback   NEXT_MOUNT_TYPE             NUMERIC(10, 0),
--rollback   NEXT_VID                    VARCHAR2(100),
--rollback   NEXT_TAPE_POOL              VARCHAR2(100),
--rollback   NEXT_PRIORITY               NUMERIC(20, 0),
--rollback   NEXT_ACTIVITY               VARCHAR2(100),
--rollback   NEXT_ACTIVITY_WEIGHT        VARCHAR2(100),
--rollback   DEV_FILE_NAME               VARCHAR2(100),
--rollback   RAW_LIBRARY_SLOT            VARCHAR2(100),
--rollback   CURRENT_VO                  VARCHAR2(100),
--rollback   NEXT_VO                     VARCHAR2(100),
--rollback   USER_COMMENT                VARCHAR2(1000),
--rollback   CREATION_LOG_USER_NAME      VARCHAR2(100),
--rollback   CREATION_LOG_HOST_NAME      VARCHAR2(100),
--rollback   CREATION_LOG_TIME           NUMERIC(20, 0),
--rollback   LAST_UPDATE_USER_NAME       VARCHAR2(100),
--rollback   LAST_UPDATE_HOST_NAME       VARCHAR2(100),
--rollback   LAST_UPDATE_TIME            NUMERIC(20, 0),
--rollback   DISK_SYSTEM_NAME            VARCHAR2(100)   CONSTRAINT DRIVE_STATE_DSN_NN NOT NULL,
--rollback   RESERVED_BYTES              NUMERIC(20, 0)  CONSTRAINT DRIVE_STATE_RB_NN  NOT NULL,
--rollback   CONSTRAINT DRIVE_STATE_DN_PK PRIMARY KEY(DRIVE_NAME),
--rollback   CONSTRAINT DRIVE_STATE_DU_BOOL_CK CHECK(DESIRED_UP IN ('0', '1')),
--rollback   CONSTRAINT DRIVE_STATE_DFD_BOOL_CK CHECK(DESIRED_FORCE_DOWN IN ('0', '1')),
--rollback   CONSTRAINT DRIVE_STATE_DS_STRING_CK CHECK(DRIVE_STATUS IN ('DOWN', 'UP', 'PROBING', 'STARTING',
--rollback   'MOUNTING', 'TRANSFERING', 'UNLOADING', 'UNMOUNTING', 'DRAININGTODISK', 'CLEANINGUP', 'SHUTDOWN', 'UNKNOWN'))
--rollback );

--changeset mvelosob:13 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
DROP TABLE ACTIVITIES_WEIGHTS;
--rollback CREATE TABLE ACTIVITIES_WEIGHTS (
--rollback  DISK_INSTANCE_NAME       VARCHAR2(100),
--rollback  ACTIVITY                 VARCHAR2(100),
--rollback  WEIGHT                   VARCHAR2(100),
--rollback  USER_COMMENT             VARCHAR2(1000)   CONSTRAINT ACTIV_WEIGHTS_UC_NN   NOT NULL,
--rollback  CREATION_LOG_USER_NAME   VARCHAR2(100)    CONSTRAINT ACTIV_WEIGHTS_CLUN_NN NOT NULL,
--rollback  CREATION_LOG_HOST_NAME   VARCHAR2(100)    CONSTRAINT ACTIV_WEIGHTS_CLHN_NN NOT NULL,
--rollback  CREATION_LOG_TIME        NUMERIC(20, 0)      CONSTRAINT ACTIV_WEIGHTS_CLT_NN  NOT NULL,
--rollback  LAST_UPDATE_USER_NAME    VARCHAR2(100)    CONSTRAINT ACTIV_WEIGHTS_LUUN_NN NOT NULL,
--rollback  LAST_UPDATE_HOST_NAME    VARCHAR2(100)    CONSTRAINT ACTIV_WEIGHTS_LUHN_NN NOT NULL,
--rollback  LAST_UPDATE_TIME         NUMERIC(20, 0)      CONSTRAINT ACTIV_WEIGHTS_LUT_NN  NOT NULL
--rollback );


--changeset mvelosob:14 failOnError:true dbms:oracle
--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:"4.6" SELECT CONCAT(CONCAT(CAST(SCHEMA_VERSION_MAJOR as VARCHAR(10)),'.'), CAST(SCHEMA_VERSION_MINOR AS VARCHAR(10))) AS CATALOGUE_VERSION FROM CTA_CATALOGUE;
UPDATE CTA_CATALOGUE SET STATUS='PRODUCTION';
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=10;
UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=0;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=NULL;
UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=NULL;
--rollback UPDATE CTA_CATALOGUE SET STATUS='UPGRADING';
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MAJOR=4;
--rollback UPDATE CTA_CATALOGUE SET SCHEMA_VERSION_MINOR=6;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MAJOR=10;
--rollback UPDATE CTA_CATALOGUE SET NEXT_SCHEMA_VERSION_MINOR=0;