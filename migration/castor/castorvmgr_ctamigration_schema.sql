/*
 * @project      The CERN Tape Archive (CTA)
 * @copyright    Copyright © 2019-2022 CERN
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

UNDEF ctaSchema
ACCEPT ctaSchema CHAR PROMPT 'Enter the username of the CTA schema: ';

GRANT SELECT ON Vmgr_tape_side TO &ctaSchema;
GRANT SELECT ON Vmgr_tape_info TO &ctaSchema;
GRANT SELECT ON Vmgr_tape_dgnmap TO &ctaSchema;

UNDEF cnsSchema
ACCEPT cnsSchema CHAR PROMPT 'Enter the username of the CASTOR Nameserver schema: ';

GRANT UPDATE ON Vmgr_tape_side TO &cnsSchema;
