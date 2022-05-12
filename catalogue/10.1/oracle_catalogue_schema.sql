CREATE SEQUENCE ARCHIVE_FILE_ID_SEQ
  INCREMENT BY 1
  START WITH 4294967296
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE LOGICAL_LIBRARY_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE MEDIA_TYPE_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE STORAGE_CLASS_ID_SEQ
  INCREMENT BY 1
  START WITH 10000
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE TAPE_POOL_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE VIRTUAL_ORGANIZATION_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE SEQUENCE FILE_RECYCLE_LOG_ID_SEQ
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
CREATE GLOBAL TEMPORARY TABLE TEMP_TAPE_FILE_INSERTION_BATCH(
  VID                   VARCHAR2(100),
  FSEQ                  NUMERIC(20, 0)  ,
  BLOCK_ID              NUMERIC(20, 0)  ,
  LOGICAL_SIZE_IN_BYTES NUMERIC(20, 0)  ,
  COPY_NB               NUMERIC(3, 0)   ,
  CREATION_TIME         NUMERIC(20, 0)  ,
  ARCHIVE_FILE_ID       NUMERIC(20, 0)
)
ON COMMIT DELETE ROWS;
CREATE INDEX TEMP_T_F_I_B_AFI_IDX ON TEMP_TAPE_FILE_INSERTION_BATCH(ARCHIVE_FILE_ID);
CREATE TABLE CTA_CATALOGUE(
  SCHEMA_VERSION_MAJOR    NUMERIC(20, 0)      CONSTRAINT CTA_CATALOGUE_SVM1_NN NOT NULL,
  SCHEMA_VERSION_MINOR    NUMERIC(20, 0)      CONSTRAINT CTA_CATALOGUE_SVM2_NN NOT NULL,
  NEXT_SCHEMA_VERSION_MAJOR NUMERIC(20, 0),
  NEXT_SCHEMA_VERSION_MINOR NUMERIC(20, 0),
  STATUS                  VARCHAR2(100),
  IS_PRODUCTION           CHAR(1)         DEFAULT '0' CONSTRAINT CTA_CATALOGUE_IP_NN NOT NULL,
  CONSTRAINT CTA_CATALOGUE_IP_BOOL_CK     CHECK(IS_PRODUCTION IN ('0','1'))
);
CREATE TABLE ADMIN_USER(
  ADMIN_USER_NAME         VARCHAR2(100)    CONSTRAINT ADMIN_USER_AUN_NN  NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT ADMIN_USER_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT ADMIN_USER_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT ADMIN_USER_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT ADMIN_USER_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT ADMIN_USER_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT ADMIN_USER_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT ADMIN_USER_LUT_NN  NOT NULL,
  CONSTRAINT ADMIN_USER_PK PRIMARY KEY(ADMIN_USER_NAME)
);
CREATE UNIQUE INDEX ADMIN_USER_AUN_UN_IDX ON ADMIN_USER(LOWER(ADMIN_USER_NAME));
CREATE TABLE DISK_INSTANCE(
  DISK_INSTANCE_NAME      VARCHAR2(100)  CONSTRAINT DISK_INSTANCE_DINM_NN NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT DISK_INSTANCE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_LUT_NN  NOT NULL,
  CONSTRAINT DISK_INSTANCE_PK PRIMARY KEY(DISK_INSTANCE_NAME)
);
CREATE UNIQUE INDEX DISK_INSTANCE_DIN_UN_IDX ON DISK_INSTANCE(LOWER(DISK_INSTANCE_NAME));
CREATE TABLE DISK_INSTANCE_SPACE(
  DISK_INSTANCE_NAME        VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_DINM_NN NOT NULL,
  DISK_INSTANCE_SPACE_NAME  VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_DISNM_NN NOT NULL,
  FREE_SPACE_QUERY_URL      VARCHAR2(1000)   CONSTRAINT DISK_INSTANCE_SPACE_FSQU_NN NOT NULL,
  REFRESH_INTERVAL          NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_SPACE_RI_NN   NOT NULL,
  LAST_REFRESH_TIME         NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_SPACE_LRT_NN   NOT NULL,
  FREE_SPACE                NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_SPACE_TFS_NN  NOT NULL,
  USER_COMMENT              VARCHAR2(1000)   CONSTRAINT DISK_INSTANCE_SPACE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME    VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME    VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME         NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_SPACE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME     VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME     VARCHAR2(100)    CONSTRAINT DISK_INSTANCE_SPACE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME          NUMERIC(20, 0)      CONSTRAINT DISK_INSTANCE_SPACE_LUT_NN  NOT NULL,
  CONSTRAINT DISK_INSTANCE_SPACE_PK PRIMARY KEY(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME),
  CONSTRAINT DISK_INSTANCE_SPACE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME)
);
CREATE UNIQUE INDEX DISK_INSTNCE_SPCE_DISN_UN_IDX ON DISK_INSTANCE_SPACE(LOWER(DISK_INSTANCE_SPACE_NAME));

CREATE TABLE DISK_SYSTEM(
  DISK_SYSTEM_NAME        VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_DSNM_NN NOT NULL,
  DISK_INSTANCE_NAME       VARCHAR2(100)   CONSTRAINT DISK_SYSTEM_DIN_NN NOT NULL,   
  DISK_INSTANCE_SPACE_NAME VARCHAR2(100)   CONSTRAINT DISK_SYSTEM_DISN_NN NOT NULL,   
  FILE_REGEXP             VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_FR_NN   NOT NULL,
  FREE_SPACE_QUERY_URL    VARCHAR2(1000)   , 
  REFRESH_INTERVAL        NUMERIC(20, 0)      , 
  TARGETED_FREE_SPACE     NUMERIC(20, 0)      CONSTRAINT DISK_SYSTEM_TFS_NN  NOT NULL,
  SLEEP_TIME              NUMERIC(20, 0)      CONSTRAINT DISK_SYSTEM_ST_NN   NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT DISK_SYSTEM_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT DISK_SYSTEM_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT DISK_SYSTEM_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT DISK_SYSTEM_LUT_NN  NOT NULL,
  CONSTRAINT NAME_PK PRIMARY KEY(DISK_SYSTEM_NAME),
  CONSTRAINT DISK_SYSTEM_DIN_DISN_FK FOREIGN KEY(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME) REFERENCES DISK_INSTANCE_SPACE(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME)
);
CREATE UNIQUE INDEX DISK_SYSTEM_DSN_UN_IDX ON DISK_SYSTEM(LOWER(DISK_SYSTEM_NAME));
CREATE INDEX DISK_SYSTEM_DIN_DISN_IDX ON DISK_SYSTEM(DISK_INSTANCE_NAME, DISK_INSTANCE_SPACE_NAME);
CREATE TABLE VIRTUAL_ORGANIZATION(
  VIRTUAL_ORGANIZATION_ID NUMERIC(20, 0)      CONSTRAINT VIRTUAL_ORGANIZATION_VOI_NN  NOT NULL,
  VIRTUAL_ORGANIZATION_NAME VARCHAR2(100)  CONSTRAINT VIRTUAL_ORGANIZATION_VON_NN  NOT NULL,
  READ_MAX_DRIVES NUMERIC(20, 0)              CONSTRAINT VIRTUAL_ORGANIZATION_RMD_NN  NOT NULL,
  WRITE_MAX_DRIVES NUMERIC(20, 0)             CONSTRAINT VIRTUAL_ORGANIZATION_WMD_NN  NOT NULL,
  MAX_FILE_SIZE NUMERIC(20, 0)                CONSTRAINT VIRTUAL_ORGANIZATION_MFS_NN  NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT VIRTUAL_ORGANIZATION_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT VIRTUAL_ORGANIZATION_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT VIRTUAL_ORGANIZATION_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT VIRTUAL_ORGANIZATION_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT VIRTUAL_ORGANIZATION_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT VIRTUAL_ORGANIZATION_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT VIRTUAL_ORGANIZATION_LUT_NN  NOT NULL,
  DISK_INSTANCE_NAME      VARCHAR2(100)    CONSTRAINT VIRTUAL_ORGANIZATION_DIN_NN  NOT NULL,
  CONSTRAINT VIRTUAL_ORGANIZATION_PK PRIMARY KEY(VIRTUAL_ORGANIZATION_ID),
  CONSTRAINT VIRTUAL_ORGANIZATION_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME)
);
CREATE UNIQUE INDEX VIRTUAL_ORG_VON_UN_IDX ON VIRTUAL_ORGANIZATION(LOWER(VIRTUAL_ORGANIZATION_NAME));
CREATE INDEX VIRTUAL_ORG_DIN_IDX ON VIRTUAL_ORGANIZATION(DISK_INSTANCE_NAME);

CREATE TABLE STORAGE_CLASS(
  STORAGE_CLASS_ID        NUMERIC(20, 0)      CONSTRAINT STORAGE_CLASS_SCI_NN  NOT NULL,
  STORAGE_CLASS_NAME      VARCHAR2(100)    CONSTRAINT STORAGE_CLASS_SCN_NN  NOT NULL,
  NB_COPIES               NUMERIC(3, 0)       CONSTRAINT STORAGE_CLASS_NC_NN   NOT NULL,
  VIRTUAL_ORGANIZATION_ID NUMERIC(20, 0)      CONSTRAINT STORAGE_CLASS_VOI_NN  NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT STORAGE_CLASS_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT STORAGE_CLASS_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT STORAGE_CLASS_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT STORAGE_CLASS_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT STORAGE_CLASS_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT STORAGE_CLASS_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT STORAGE_CLASS_LUT_NN  NOT NULL,
  CONSTRAINT STORAGE_CLASS_PK PRIMARY KEY(STORAGE_CLASS_ID),
  CONSTRAINT STORAGE_CLASS_VOI_FK FOREIGN KEY(VIRTUAL_ORGANIZATION_ID) REFERENCES VIRTUAL_ORGANIZATION(VIRTUAL_ORGANIZATION_ID)
);
CREATE UNIQUE INDEX STORAGE_CLASS_SCN_UN_IDX ON STORAGE_CLASS(LOWER(STORAGE_CLASS_NAME));
CREATE INDEX STORAGE_CLASS_VOI_IDX ON STORAGE_CLASS(VIRTUAL_ORGANIZATION_ID);
CREATE TABLE TAPE_POOL(
  TAPE_POOL_ID            NUMERIC(20, 0)      CONSTRAINT TAPE_POOL_TPI_NN  NOT NULL,
  TAPE_POOL_NAME          VARCHAR2(100)    CONSTRAINT TAPE_POOL_TPN_NN  NOT NULL,
  VIRTUAL_ORGANIZATION_ID NUMERIC(20, 0)      CONSTRAINT TAPE_POOL_VOI_NN  NOT NULL,
  NB_PARTIAL_TAPES        NUMERIC(20, 0)      CONSTRAINT TAPE_POOL_NPT_NN  NOT NULL,
  IS_ENCRYPTED            CHAR(1)         CONSTRAINT TAPE_POOL_IE_NN   NOT NULL,
  SUPPLY                  VARCHAR2(100),
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT TAPE_POOL_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT TAPE_POOL_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT TAPE_POOL_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT TAPE_POOL_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT TAPE_POOL_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT TAPE_POOL_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT TAPE_POOL_LUT_NN  NOT NULL,
  CONSTRAINT TAPE_POOL_PK PRIMARY KEY(TAPE_POOL_ID),
  CONSTRAINT TAPE_POOL_IS_ENCRYPTED_BOOL_CK CHECK(IS_ENCRYPTED IN ('0', '1')),
  CONSTRAINT TAPE_POOL_VO_FK FOREIGN KEY(VIRTUAL_ORGANIZATION_ID) REFERENCES VIRTUAL_ORGANIZATION(VIRTUAL_ORGANIZATION_ID)
);
CREATE UNIQUE INDEX TAPE_POOL_TPN_UN_IDX ON TAPE_POOL(LOWER(TAPE_POOL_NAME));
CREATE INDEX TAPE_POOL_VOI_IDX ON TAPE_POOL(VIRTUAL_ORGANIZATION_ID);
CREATE TABLE ARCHIVE_ROUTE(
  STORAGE_CLASS_ID        NUMERIC(20, 0)      CONSTRAINT ARCHIVE_ROUTE_SCI_NN  NOT NULL,
  COPY_NB                 NUMERIC(3, 0)       CONSTRAINT ARCHIVE_ROUTE_CN_NN   NOT NULL,
  TAPE_POOL_ID            NUMERIC(20, 0)      CONSTRAINT ARCHIVE_ROUTE_TPI_NN  NOT NULL,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT ARCHIVE_ROUTE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT ARCHIVE_ROUTE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT ARCHIVE_ROUTE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT ARCHIVE_ROUTE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT ARCHIVE_ROUTE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT ARCHIVE_ROUTE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT ARCHIVE_ROUTE_LUT_NN  NOT NULL,
  CONSTRAINT ARCHIVE_ROUTE_PK PRIMARY KEY(STORAGE_CLASS_ID, COPY_NB),
  CONSTRAINT ARCHIVE_ROUTE_STORAGE_CLASS_FK FOREIGN KEY(STORAGE_CLASS_ID) REFERENCES STORAGE_CLASS(STORAGE_CLASS_ID),
  CONSTRAINT ARCHIVE_ROUTE_TAPE_POOL_FK FOREIGN KEY(TAPE_POOL_ID) REFERENCES TAPE_POOL(TAPE_POOL_ID),
  CONSTRAINT ARCHIVE_ROUTE_COPY_NB_GT_0_CK CHECK(COPY_NB > 0),
  CONSTRAINT ARCHIVE_ROUTE_SCI_TPI_UN UNIQUE(STORAGE_CLASS_ID, TAPE_POOL_ID)
);
CREATE TABLE MEDIA_TYPE(
  MEDIA_TYPE_ID          NUMERIC(20, 0)    CONSTRAINT MEDIA_TYPE_MTI_NN  NOT NULL,
  MEDIA_TYPE_NAME        VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_MTN_NN  NOT NULL,
  CARTRIDGE              VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_C_NN    NOT NULL,
  CAPACITY_IN_BYTES      NUMERIC(20, 0)    CONSTRAINT MEDIA_TYPE_CIB_NN  NOT NULL,
  PRIMARY_DENSITY_CODE   NUMERIC(3, 0),
  SECONDARY_DENSITY_CODE NUMERIC(3, 0),
  NB_WRAPS               NUMERIC(10, 0),
  MIN_LPOS               NUMERIC(20, 0),
  MAX_LPOS               NUMERIC(20, 0),
  USER_COMMENT           VARCHAR2(1000) CONSTRAINT MEDIA_TYPE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME      NUMERIC(20, 0)    CONSTRAINT MEDIA_TYPE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME  VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME  VARCHAR2(100)  CONSTRAINT MEDIA_TYPE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME       NUMERIC(20, 0)    CONSTRAINT MEDIA_TYPE_LUT_NN  NOT NULL,
  CONSTRAINT MEDIA_TYPE_PK PRIMARY KEY(MEDIA_TYPE_ID)
);
CREATE UNIQUE INDEX MEDIA_TYPE_MTN_UN_IDX ON MEDIA_TYPE(LOWER(MEDIA_TYPE_NAME));
CREATE TABLE LOGICAL_LIBRARY(
  LOGICAL_LIBRARY_ID      NUMERIC(20, 0)      CONSTRAINT LOGICAL_LIBRARY_LLI_NN  NOT NULL,
  LOGICAL_LIBRARY_NAME    VARCHAR2(100)    CONSTRAINT LOGICAL_LIBRARY_LLN_NN  NOT NULL,
  IS_DISABLED             CHAR(1)         DEFAULT '0' CONSTRAINT LOGICAL_LIBRARY_ID_NN NOT NULL,
  DISABLED_REASON         VARCHAR2(1000)   ,
  USER_COMMENT            VARCHAR2(1000)   CONSTRAINT LOGICAL_LIBRARY_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT LOGICAL_LIBRARY_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT LOGICAL_LIBRARY_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT LOGICAL_LIBRARY_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT LOGICAL_LIBRARY_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT LOGICAL_LIBRARY_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT LOGICAL_LIBRARY_LUT_NN  NOT NULL,
  CONSTRAINT LOGICAL_LIBRARY_PK PRIMARY KEY(LOGICAL_LIBRARY_ID),
  CONSTRAINT LOGICAL_LIBRARY_ID_BOOL_CK CHECK(IS_DISABLED IN ('0', '1'))
);
CREATE UNIQUE INDEX LOGICAL_LIBRARY_LLN_UN_IDX ON LOGICAL_LIBRARY(LOWER(LOGICAL_LIBRARY_NAME));
CREATE TABLE TAPE(
  VID                     VARCHAR2(100)    CONSTRAINT TAPE_V_NN    NOT NULL,
  MEDIA_TYPE_ID           NUMERIC(20, 0)      CONSTRAINT TAPE_MTID_NN NOT NULL,
  VENDOR                  VARCHAR2(100)    CONSTRAINT TAPE_V2_NN   NOT NULL,
  LOGICAL_LIBRARY_ID      NUMERIC(20, 0)      CONSTRAINT TAPE_LLI_NN  NOT NULL,
  TAPE_POOL_ID            NUMERIC(20, 0)      CONSTRAINT TAPE_TPI_NN  NOT NULL,
  ENCRYPTION_KEY_NAME     VARCHAR2(100),
  DATA_IN_BYTES           NUMERIC(20, 0)      CONSTRAINT TAPE_DIB_NN  NOT NULL,
  LAST_FSEQ               NUMERIC(20, 0)      CONSTRAINT TAPE_LF_NN   NOT NULL,
  NB_MASTER_FILES         NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_NB_MASTER_FILES_NN NOT NULL,
  MASTER_DATA_IN_BYTES    NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_MASTER_DATA_IN_BYTES_NN NOT NULL,
  IS_FULL                 CHAR(1)         CONSTRAINT TAPE_IF_NN   NOT NULL,
  IS_FROM_CASTOR          CHAR(1)         CONSTRAINT TAPE_IFC_NN  NOT NULL,
  DIRTY                   CHAR(1)         DEFAULT '1' CONSTRAINT TAPE_DIRTY_NN NOT NULL,
  NB_COPY_NB_1            NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_NB_COPY_NB_1_NN NOT NULL,
  COPY_NB_1_IN_BYTES      NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_COPY_NB_1_IN_BYTES_NN NOT NULL,
  NB_COPY_NB_GT_1         NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_NB_COPY_NB_GT_1_NN NOT NULL,
  COPY_NB_GT_1_IN_BYTES   NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_COPY_NB_GT_1_IN_BYTES_NN NOT NULL,
  LABEL_FORMAT            CHAR(1),
  LABEL_DRIVE             VARCHAR2(100),
  LABEL_TIME              NUMERIC(20, 0),
  LAST_READ_DRIVE         VARCHAR2(100),
  LAST_READ_TIME          NUMERIC(20, 0),
  LAST_WRITE_DRIVE        VARCHAR2(100),
  LAST_WRITE_TIME         NUMERIC(20, 0),
  READ_MOUNT_COUNT        NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_RMC_NN NOT NULL,
  WRITE_MOUNT_COUNT       NUMERIC(20, 0)      DEFAULT 0 CONSTRAINT TAPE_WMC_NN NOT NULL,
  USER_COMMENT            VARCHAR2(1000),
  TAPE_STATE              VARCHAR2(100)    CONSTRAINT TAPE_TS_NN NOT NULL,
  STATE_REASON            VARCHAR2(1000),
  STATE_UPDATE_TIME       NUMERIC(20, 0)      CONSTRAINT TAPE_SUT_NN NOT NULL,
  STATE_MODIFIED_BY       VARCHAR2(100)    CONSTRAINT TAPE_SMB_NN NOT NULL,
  CREATION_LOG_USER_NAME  VARCHAR2(100)    CONSTRAINT TAPE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME  VARCHAR2(100)    CONSTRAINT TAPE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME       NUMERIC(20, 0)      CONSTRAINT TAPE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME   VARCHAR2(100)    CONSTRAINT TAPE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME   VARCHAR2(100)    CONSTRAINT TAPE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME        NUMERIC(20, 0)      CONSTRAINT TAPE_LUT_NN  NOT NULL,
  VERIFICATION_STATUS     VARCHAR2(1000),
  CONSTRAINT TAPE_PK PRIMARY KEY(VID),
  CONSTRAINT TAPE_LOGICAL_LIBRARY_FK FOREIGN KEY(LOGICAL_LIBRARY_ID) REFERENCES LOGICAL_LIBRARY(LOGICAL_LIBRARY_ID),
  CONSTRAINT TAPE_TAPE_POOL_FK FOREIGN KEY(TAPE_POOL_ID) REFERENCES TAPE_POOL(TAPE_POOL_ID),
  CONSTRAINT TAPE_IS_FULL_BOOL_CK CHECK(IS_FULL IN ('0', '1')),
  CONSTRAINT TAPE_IS_FROM_CASTOR_BOOL_CK CHECK(IS_FROM_CASTOR IN ('0', '1')),
  CONSTRAINT TAPE_DIRTY_BOOL_CK CHECK(DIRTY IN ('0','1')),
  CONSTRAINT TAPE_STATE_CK CHECK(TAPE_STATE IN ('ACTIVE', 'REPACKING_PENDING', 'REPACKING', 'DISABLED', 'BROKEN_PENDING', 'BROKEN')),
  CONSTRAINT TAPE_MEDIA_TYPE_FK FOREIGN KEY(MEDIA_TYPE_ID) REFERENCES MEDIA_TYPE(MEDIA_TYPE_ID)
);
CREATE UNIQUE INDEX TAPE_VID_UN_IDX ON TAPE(LOWER(VID));
CREATE INDEX TAPE_TAPE_POOL_ID_IDX ON TAPE(TAPE_POOL_ID);
CREATE INDEX TAPE_STATE_IDX ON TAPE(TAPE_STATE);
CREATE INDEX TAPE_LLI_IDX ON TAPE(LOGICAL_LIBRARY_ID);
CREATE INDEX TAPE_MTI_IDX ON TAPE(MEDIA_TYPE_ID);
CREATE TABLE MOUNT_POLICY(
  MOUNT_POLICY_NAME          VARCHAR2(100)    CONSTRAINT MOUNT_POLICY_MPN_NN  NOT NULL,
  ARCHIVE_PRIORITY           NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_AP_NN   NOT NULL,
  ARCHIVE_MIN_REQUEST_AGE    NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_AMRA_NN NOT NULL,
  RETRIEVE_PRIORITY          NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_RP_NN   NOT NULL,
  RETRIEVE_MIN_REQUEST_AGE   NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_RMRA_NN NOT NULL,
  USER_COMMENT               VARCHAR2(1000)   CONSTRAINT MOUNT_POLICY_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME     VARCHAR2(100)    CONSTRAINT MOUNT_POLICY_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME     VARCHAR2(100)    CONSTRAINT MOUNT_POLICY_CLHN_NN NOT NULL,
  CREATION_LOG_TIME          NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME      VARCHAR2(100)    CONSTRAINT MOUNT_POLICY_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME      VARCHAR2(100)    CONSTRAINT MOUNT_POLICY_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME           NUMERIC(20, 0)      CONSTRAINT MOUNT_POLICY_LUT_NN  NOT NULL,
  CONSTRAINT MOUNT_POLICY_PK PRIMARY KEY(MOUNT_POLICY_NAME)
);
CREATE UNIQUE INDEX MOUNT_POLICY_MPN_UN_IDX ON MOUNT_POLICY(LOWER(MOUNT_POLICY_NAME));
CREATE TABLE REQUESTER_ACTIVITY_MOUNT_RULE(
  DISK_INSTANCE_NAME     VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_DIN_NN  NOT NULL,
  REQUESTER_NAME         VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_RN_NN   NOT NULL,
  ACTIVITY_REGEX         VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_AR_NN   NOT NULL,
  MOUNT_POLICY_NAME      VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_MPN_NN  NOT NULL,
  USER_COMMENT           VARCHAR2(1000)   CONSTRAINT RQSTER_ACT_RULE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME      NUMERIC(20, 0)      CONSTRAINT RQSTER_ACT_RULE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_ACT_RULE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME       NUMERIC(20, 0)      CONSTRAINT RQSTER_ACT_RULE_LUT_NN  NOT NULL,
  CONSTRAINT RQSTER_ACT_RULE_PK PRIMARY KEY(DISK_INSTANCE_NAME, REQUESTER_NAME, ACTIVITY_REGEX),
  CONSTRAINT RQSTER_ACT_RULE_MNT_PLC_FK FOREIGN KEY(MOUNT_POLICY_NAME) REFERENCES MOUNT_POLICY(MOUNT_POLICY_NAME),
  CONSTRAINT RQSTER_ACT_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME)
);
CREATE INDEX REQ_ACT_MNT_RULE_MPN_IDX ON REQUESTER_ACTIVITY_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX REQ_ACT_MNT_RULE_DIN_IDX ON REQUESTER_ACTIVITY_MOUNT_RULE(DISK_INSTANCE_NAME);

CREATE TABLE REQUESTER_MOUNT_RULE(
  DISK_INSTANCE_NAME     VARCHAR2(100)    CONSTRAINT RQSTER_RULE_DIN_NN  NOT NULL,
  REQUESTER_NAME         VARCHAR2(100)    CONSTRAINT RQSTER_RULE_RN_NN   NOT NULL,
  MOUNT_POLICY_NAME      VARCHAR2(100)    CONSTRAINT RQSTER_RULE_MPN_NN  NOT NULL,
  USER_COMMENT           VARCHAR2(1000)   CONSTRAINT RQSTER_RULE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME VARCHAR2(100)    CONSTRAINT RQSTER_RULE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME VARCHAR2(100)    CONSTRAINT RQSTER_RULE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME      NUMERIC(20, 0)      CONSTRAINT RQSTER_RULE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_RULE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_RULE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME       NUMERIC(20, 0)      CONSTRAINT RQSTER_RULE_LUT_NN  NOT NULL,
  CONSTRAINT RQSTER_RULE_PK PRIMARY KEY(DISK_INSTANCE_NAME, REQUESTER_NAME),
  CONSTRAINT RQSTER_RULE_MNT_PLC_FK FOREIGN KEY(MOUNT_POLICY_NAME) REFERENCES MOUNT_POLICY(MOUNT_POLICY_NAME),
  CONSTRAINT RQSTER_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME)
);
CREATE INDEX REQ_MNT_RULE_MPN_IDX ON REQUESTER_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX REQ_MNT_RULE_DIN_IDX ON REQUESTER_MOUNT_RULE(DISK_INSTANCE_NAME);

CREATE TABLE REQUESTER_GROUP_MOUNT_RULE(
  DISK_INSTANCE_NAME     VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_DIN_NN  NOT NULL,
  REQUESTER_GROUP_NAME   VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_RGN_NN  NOT NULL,
  MOUNT_POLICY_NAME      VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_MPN_NN  NOT NULL,
  USER_COMMENT           VARCHAR2(1000)   CONSTRAINT RQSTER_GRP_RULE_UC_NN   NOT NULL,
  CREATION_LOG_USER_NAME VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_CLUN_NN NOT NULL,
  CREATION_LOG_HOST_NAME VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_CLHN_NN NOT NULL,
  CREATION_LOG_TIME      NUMERIC(20, 0)      CONSTRAINT RQSTER_GRP_RULE_CLT_NN  NOT NULL,
  LAST_UPDATE_USER_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_LUUN_NN NOT NULL,
  LAST_UPDATE_HOST_NAME  VARCHAR2(100)    CONSTRAINT RQSTER_GRP_RULE_LUHN_NN NOT NULL,
  LAST_UPDATE_TIME       NUMERIC(20, 0)      CONSTRAINT RQSTER_GRP_RULE_LUT_NN  NOT NULL,
  CONSTRAINT RQSTER_GRP_RULE_PK PRIMARY KEY(DISK_INSTANCE_NAME, REQUESTER_GROUP_NAME),
  CONSTRAINT RQSTER_GRP_RULE_MNT_PLC_FK FOREIGN KEY(MOUNT_POLICY_NAME) REFERENCES MOUNT_POLICY(MOUNT_POLICY_NAME),
  CONSTRAINT RQSTER_GRP_RULE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME)

);
CREATE INDEX REQ_GRP_MNT_RULE_MPN_IDX ON REQUESTER_GROUP_MOUNT_RULE(MOUNT_POLICY_NAME);
CREATE INDEX REQ_GRP_MNT_RULE_DIN_IDX ON REQUESTER_GROUP_MOUNT_RULE(DISK_INSTANCE_NAME);

CREATE TABLE ARCHIVE_FILE(
  ARCHIVE_FILE_ID         NUMERIC(20, 0)      CONSTRAINT ARCHIVE_FILE_AFI_NN  NOT NULL,
  DISK_INSTANCE_NAME      VARCHAR2(100)    CONSTRAINT ARCHIVE_FILE_DIN_NN  NOT NULL,
  DISK_FILE_ID            VARCHAR2(100)    CONSTRAINT ARCHIVE_FILE_DFI_NN  NOT NULL,
  DISK_FILE_UID           NUMERIC(10, 0)      CONSTRAINT ARCHIVE_FILE_DFUID_NN  NOT NULL,
  DISK_FILE_GID           NUMERIC(10, 0)      CONSTRAINT ARCHIVE_FILE_DFGID_NN  NOT NULL,
  SIZE_IN_BYTES           NUMERIC(20, 0)      CONSTRAINT ARCHIVE_FILE_SIB_NN  NOT NULL,
  CHECKSUM_BLOB           RAW(200),
  CHECKSUM_ADLER32        NUMERIC(10, 0)      CONSTRAINT ARCHIVE_FILE_CB2_NN  NOT NULL,
  STORAGE_CLASS_ID        NUMERIC(20, 0)      CONSTRAINT ARCHIVE_FILE_SCI_NN  NOT NULL,
  CREATION_TIME           NUMERIC(20, 0)      CONSTRAINT ARCHIVE_FILE_CT2_NN  NOT NULL,
  RECONCILIATION_TIME     NUMERIC(20, 0)      CONSTRAINT ARCHIVE_FILE_RT_NN   NOT NULL,
  IS_DELETED              CHAR(1)         DEFAULT '0' CONSTRAINT ARCHIVE_FILE_ID_NN NOT NULL,
  COLLOCATION_HINT        VARCHAR2(100),
  CONSTRAINT ARCHIVE_FILE_PK PRIMARY KEY(ARCHIVE_FILE_ID),
  CONSTRAINT ARCHIVE_FILE_STORAGE_CLASS_FK FOREIGN KEY(STORAGE_CLASS_ID) REFERENCES STORAGE_CLASS(STORAGE_CLASS_ID),
  CONSTRAINT ARCHIVE_FILE_DIN_FK FOREIGN KEY(DISK_INSTANCE_NAME) REFERENCES DISK_INSTANCE(DISK_INSTANCE_NAME),
  CONSTRAINT ARCHIVE_FILE_DIN_DFI_UN UNIQUE(DISK_INSTANCE_NAME, DISK_FILE_ID),
  CONSTRAINT ARCHIVE_FILE_ID_BOOL_CK CHECK(IS_DELETED IN ('0', '1'))
);
CREATE INDEX ARCHIVE_FILE_DIN_IDX ON ARCHIVE_FILE(DISK_INSTANCE_NAME);
CREATE INDEX ARCHIVE_FILE_DFI_IDX ON ARCHIVE_FILE(DISK_FILE_ID);
CREATE INDEX ARCHIVE_FILE_SCI_IDX ON ARCHIVE_FILE(STORAGE_CLASS_ID);
CREATE TABLE TAPE_FILE(
  VID                      VARCHAR2(100)   CONSTRAINT TAPE_FILE_V_NN    NOT NULL,
  FSEQ                     NUMERIC(20, 0)     CONSTRAINT TAPE_FILE_F_NN    NOT NULL,
  BLOCK_ID                 NUMERIC(20, 0)     CONSTRAINT TAPE_FILE_BI_NN   NOT NULL,
  LOGICAL_SIZE_IN_BYTES    NUMERIC(20, 0)     CONSTRAINT TAPE_FILE_CSIB_NN NOT NULL,
  COPY_NB                  NUMERIC(3, 0)      CONSTRAINT TAPE_FILE_CN_NN   NOT NULL,
  CREATION_TIME            NUMERIC(20, 0)     CONSTRAINT TAPE_FILE_CT_NN   NOT NULL,
  ARCHIVE_FILE_ID          NUMERIC(20, 0)     CONSTRAINT TAPE_FILE_AFI_NN  NOT NULL,
  CONSTRAINT TAPE_FILE_PK PRIMARY KEY(VID, FSEQ),
  CONSTRAINT TAPE_FILE_TAPE_FK FOREIGN KEY(VID)
    REFERENCES TAPE(VID),
  CONSTRAINT TAPE_FILE_ARCHIVE_FILE_FK FOREIGN KEY(ARCHIVE_FILE_ID)
    REFERENCES ARCHIVE_FILE(ARCHIVE_FILE_ID),
  CONSTRAINT TAPE_FILE_VID_BLOCK_ID_UN UNIQUE(VID, BLOCK_ID),
  CONSTRAINT TAPE_FILE_COPY_NB_GT_0_CK CHECK(COPY_NB > 0)
);
CREATE INDEX TAPE_FILE_VID_IDX ON TAPE_FILE(VID);
CREATE INDEX TAPE_FILE_ARCHIVE_FILE_ID_IDX ON TAPE_FILE(ARCHIVE_FILE_ID);
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
CREATE INDEX FILE_RECYCLE_LOG_DFI_IDX ON FILE_RECYCLE_LOG(DISK_FILE_ID);
CREATE INDEX FILE_RECYCLE_LOG_SCD_IDX ON FILE_RECYCLE_LOG(STORAGE_CLASS_ID);
CREATE INDEX FILE_RECYCLE_LOG_VID_IDX ON FILE_RECYCLE_LOG(VID);
CREATE TABLE DRIVE_CONFIG (
  DRIVE_NAME                  VARCHAR2(100)       CONSTRAINT DRIVE_CONFIG_DN_NN  NOT NULL,
  CATEGORY                    VARCHAR2(100)       CONSTRAINT DRIVE_CONFIG_C_NN   NOT NULL,
  KEY_NAME                    VARCHAR2(100)       CONSTRAINT DRIVE_CONFIG_KN_NN  NOT NULL,
  VALUE                       VARCHAR2(1000)      CONSTRAINT DRIVE_CONFIG_V_NN   NOT NULL,
  SOURCE                      VARCHAR2(100)       CONSTRAINT DRIVE_CONFIG_S_NN   NOT NULL,
  CONSTRAINT DRIVE_CONFIG_DN_PK PRIMARY KEY(KEY_NAME, DRIVE_NAME)
);
CREATE TABLE DRIVE_STATE (
  DRIVE_NAME                  VARCHAR2(100)       CONSTRAINT DRIVE_DN_NN NOT NULL,
  HOST                        VARCHAR2(100)       CONSTRAINT DRIVE_H_NN  NOT NULL,
  LOGICAL_LIBRARY             VARCHAR2(100)       CONSTRAINT DRIVE_LL_NN NOT NULL,
  SESSION_ID                  NUMERIC(20, 0),
  BYTES_TRANSFERED_IN_SESSION NUMERIC(20, 0),
  FILES_TRANSFERED_IN_SESSION NUMERIC(20, 0),
  SESSION_START_TIME          NUMERIC(20, 0),
  SESSION_ELAPSED_TIME        NUMERIC(20, 0),
  MOUNT_START_TIME            NUMERIC(20, 0),
  TRANSFER_START_TIME         NUMERIC(20, 0),
  UNLOAD_START_TIME           NUMERIC(20, 0),
  UNMOUNT_START_TIME          NUMERIC(20, 0),
  DRAINING_START_TIME         NUMERIC(20, 0),
  DOWN_OR_UP_START_TIME       NUMERIC(20, 0),
  PROBE_START_TIME            NUMERIC(20, 0),
  CLEANUP_START_TIME          NUMERIC(20, 0),
  START_START_TIME            NUMERIC(20, 0),
  SHUTDOWN_TIME               NUMERIC(20, 0),
  MOUNT_TYPE                  VARCHAR2(100)    DEFAULT 'NO_MOUNT' CONSTRAINT DRIVE_MT_NN NOT NULL,
  DRIVE_STATUS                VARCHAR2(100)    DEFAULT 'UNKNOWN' CONSTRAINT DRIVE_DS_NN NOT NULL,
  DESIRED_UP                  CHAR(1)         DEFAULT '0' CONSTRAINT DRIVE_DU_NN  NOT NULL,
  DESIRED_FORCE_DOWN          CHAR(1)         DEFAULT '0' CONSTRAINT DRIVE_DFD_NN NOT NULL,
  REASON_UP_DOWN              VARCHAR2(1000),
  CURRENT_VID                 VARCHAR2(100),
  CTA_VERSION                 VARCHAR2(100),
  CURRENT_PRIORITY            NUMERIC(20, 0),
  CURRENT_ACTIVITY            VARCHAR2(100),
  CURRENT_TAPE_POOL           VARCHAR2(100),
  NEXT_MOUNT_TYPE             VARCHAR2(100)    DEFAULT 'NO_MOUNT' CONSTRAINT DRIVE_NMT_NN NOT NULL,
  NEXT_VID                    VARCHAR2(100),
  NEXT_PRIORITY               NUMERIC(20, 0),
  NEXT_ACTIVITY               VARCHAR2(100),
  NEXT_TAPE_POOL              VARCHAR2(100),
  DEV_FILE_NAME               VARCHAR2(100),
  RAW_LIBRARY_SLOT            VARCHAR2(100),
  CURRENT_VO                  VARCHAR2(100),
  NEXT_VO                     VARCHAR2(100),
  USER_COMMENT                VARCHAR2(1000),
  CREATION_LOG_USER_NAME      VARCHAR2(100),
  CREATION_LOG_HOST_NAME      VARCHAR2(100),
  CREATION_LOG_TIME           NUMERIC(20, 0),
  LAST_UPDATE_USER_NAME       VARCHAR2(100),
  LAST_UPDATE_HOST_NAME       VARCHAR2(100),
  LAST_UPDATE_TIME            NUMERIC(20, 0),
  DISK_SYSTEM_NAME            VARCHAR2(100),
  RESERVED_BYTES              NUMERIC(20, 0),
  RESERVATION_SESSION_ID      NUMERIC(20, 0),
  CONSTRAINT DRIVE_DN_PK PRIMARY KEY(DRIVE_NAME),
  CONSTRAINT DRIVE_DU_BOOL_CK CHECK(DESIRED_UP IN ('0', '1')),
  CONSTRAINT DRIVE_DFD_BOOL_CK CHECK(DESIRED_FORCE_DOWN IN ('0', '1')),
  CONSTRAINT DRIVE_DS_STRING_CK CHECK(DRIVE_STATUS IN ('DOWN', 'UP', 'PROBING', 'STARTING',
  'MOUNTING', 'TRANSFERING', 'UNLOADING', 'UNMOUNTING', 'DRAININGTODISK', 'CLEANINGUP', 'SHUTDOWN',
  'UNKNOWN')),
  CONSTRAINT DRIVE_MT_STRING_CK CHECK(MOUNT_TYPE IN ('NO_MOUNT', 'ARCHIVE_FOR_USER',
  'ARCHIVE_FOR_REPACK', 'RETRIEVE', 'LABEL', 'ARCHIVE_ALL_TYPES')),
  CONSTRAINT DRIVE_NMT_STRING_CK CHECK(NEXT_MOUNT_TYPE IN ('NO_MOUNT', 'ARCHIVE_FOR_USER',
  'ARCHIVE_FOR_REPACK', 'RETRIEVE', 'LABEL', 'ARCHIVE_ALL_TYPES'))
);
CREATE UNIQUE INDEX DRIVE_STATE_DN_UN_IDX ON DRIVE_STATE(LOWER(DRIVE_NAME));
INSERT INTO CTA_CATALOGUE(
  SCHEMA_VERSION_MAJOR,
  SCHEMA_VERSION_MINOR,
  STATUS)
VALUES(
  10,
  1,
  'PRODUCTION');
ALTER TABLE CTA_CATALOGUE ADD CONSTRAINT CATALOGUE_STATUS_CONTENT_CK CHECK((NEXT_SCHEMA_VERSION_MAJOR IS NULL AND NEXT_SCHEMA_VERSION_MINOR IS NULL AND STATUS='PRODUCTION') OR (NEXT_SCHEMA_VERSION_MAJOR IS NOT NULL AND NEXT_SCHEMA_VERSION_MINOR IS NOT NULL AND STATUS='UPGRADING')) INITIALLY DEFERRED;

COMMIT;
