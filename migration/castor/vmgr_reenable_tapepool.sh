#!/bin/bash

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

# check arguments
if [[ $# != 1 ]]; then
  echo Re-enables a tapepool in CASTOR VMGR and reactivates the related migration routes
  echo Usage: $0 tapepool
  exit 1
fi

# check that the metadata exists for the given tapepool
[[ ! -x ~/ctaexport/migrationroutes_$1 ]] && echo 'Metadata from a previous export of tapepool' $1 'not found, aborting' && exit 1

# on the stager, restore the migration routes
cat ~/ctaexport/migrationroutes_$1 | grep -v FILECLASS | grep -v '---' | awk '{print "entermigrationroute " $1 " " $2 ":" $4}' | sh

# on the VMGR, mark all tapes back as available (but full == read-only) for the tape pool
vmgrlisttape -P $1 | awk '{print $1}' | xargs -i vmgrmodifytape -V {} --st TAPE_FULL
