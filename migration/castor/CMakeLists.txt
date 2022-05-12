# @project      The CERN Tape Archive (CTA)
# @copyright    Copyright © 2019-2022 CERN
# @license      This program is free software, distributed under the terms of the GNU General Public
#               Licence version 3 (GPL Version 3), copied verbatim in the file "COPYING". You can
#               redistribute it and/or modify it under the terms of the GPL Version 3, or (at your
#               option) any later version.
#
#               This program is distributed in the hope that it will be useful, but WITHOUT ANY
#               WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
#               PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
#               In applying this licence, CERN does not waive the privileges and immunities
#               granted to it by virtue of its status as an Intergovernmental Organization or
#               submit itself to any jurisdiction.

install(FILES
    ${CMAKE_SOURCE_DIR}/migration/castor/begin_vo_export_to_cta.sh
    ${CMAKE_SOURCE_DIR}/migration/castor/export_production_tapepool_to_cta.sh
    ${CMAKE_SOURCE_DIR}/migration/castor/tapepool_castor_to_cta.py
    ${CMAKE_SOURCE_DIR}/migration/castor/zerolen_castor_to_cta.py
    ${CMAKE_SOURCE_DIR}/migration/castor/complete_cta_export.py
    ${CMAKE_SOURCE_DIR}/migration/castor/vmgr_reenable_tapepool.sh
    DESTINATION usr/bin)
