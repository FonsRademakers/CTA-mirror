#!/bin/sh

# @project      The CERN Tape Archive (CTA)
# @copyright    Copyright © 2022 CERN
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

# Pretty Print JSON with Base64 decoding of byte-encoded fields

if [ $# -eq 1 ]
then
  cat $1
else
  cat -
fi | sed 's/\]\[/,/g' | python -mjson.tool |\
awk '/"path": / || /"name": / ||
     /"value": / ||
     /"CTA_.*": / ||
     /"sys\..*": / ||
     /"eos.btime": / {
       CODE=substr($2, 2)
       sub(/",*$/,"",CODE)
       command="echo "CODE"|base64 -d"
       command | getline DECODED
       close(command)
       sub(CODE,DECODED)
   }
   { print $0 }'
