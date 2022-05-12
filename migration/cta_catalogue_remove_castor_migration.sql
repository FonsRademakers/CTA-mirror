/*
 * @project      The CERN Tape Archive (CTA)
 * @copyright    Copyright © 2020-2022 CERN
 * @license      This program is free software, distributed under the terms of the GNU General Public
 *               Licence version 3 (GPL Version 3), copied verbatim in the file "COPYING". You can
 *               redistribute it and/or modify it under the terms of the GPL Version 3, or (at your
 *               option) any later version.
 *
 *               This program is distributed in the hope that it will be useful, but WITHOUT ANY
 *               WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *               PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 *               In applying this licence, CERN does not waive the privileges and immunities
 *               granted to it by virtue of its status as an Intergovernmental Organization or
 *               submit itself to any jurisdiction.
 */

-- Remove Procedures
DROP PROCEDURE importTapePool;
DROP PROCEDURE populateCTAFilesFromCASTOR;
DROP PROCEDURE importFromCASTOR;
DROP PROCEDURE removeCASTORMetadata;

-- Remove Types
DROP TYPE NUMLIST;

-- Remove Synonyms
DROP SYNONYM CNS_CTAFilesHelper;
DROP SYNONYM CNS_CTAFiles2ndCopyHelper;
DROP SYNONYM CNS_CTADirsHelper;
DROP SYNONYM CNS_CTAMigrationLog;
DROP SYNONYM CNS_Class_Metadata;
DROP SYNONYM CNS_Dirs_Full_Path;
DROP SYNONYM CNS_filesForCTAExport;
DROP SYNONYM CNS_zeroByteFilesForCTAExport;
DROP SYNONYM CNS_dirsForCTAExport;
DROP SYNONYM CNS_ctaLog;
DROP SYNONYM CNS_getTime;
DROP SYNONYM Vmgr_tape_side;
DROP SYNONYM vmgr_tape_info;
DROP SYNONYM Vmgr_tape_dgnmap;

-- Remove temporary table
DROP TABLE Temp_Remove_CASTOR_Metadata;

-- Remove Error Log created with dbms_errlog.create_error_log(dml_table_name => 'Tape_File');
DROP TABLE ERR$_TAPE_FILE;

-- Remove PARALLEL
ALTER TABLE ARCHIVE_FILE NOPARALLEL;
ALTER TABLE TAPE_FILE NOPARALLEL;

QUIT
