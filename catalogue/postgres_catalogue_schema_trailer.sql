ALTER TABLE ARCHIVE_FILE DROP CONSTRAINT
  ARCHIVE_FILE_DIN_DFI_UN;
ALTER TABLE ARCHIVE_FILE ADD CONSTRAINT
  ARCHIVE_FILE_DIN_DFI_UN UNIQUE(DISK_INSTANCE_NAME, DISK_FILE_ID) DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE CTA_CATALOGUE ADD CONSTRAINT
  CATALOGUE_STATUS_CONTENT_CK CHECK((NEXT_SCHEMA_VERSION_MAJOR IS NULL AND NEXT_SCHEMA_VERSION_MINOR IS NULL AND STATUS='PRODUCTION') OR (STATUS='UPGRADING'));
