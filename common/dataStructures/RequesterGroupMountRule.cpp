/*
 * @project      The CERN Tape Archive (CTA)
 * @copyright    Copyright © 2021-2022 CERN
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

#include "common/dataStructures/RequesterGroupMountRule.hpp"
#include "common/dataStructures/utils.hpp"
#include "common/exception/Exception.hpp"

namespace cta {
namespace common {
namespace dataStructures {

//------------------------------------------------------------------------------
// constructor
//------------------------------------------------------------------------------
RequesterGroupMountRule::RequesterGroupMountRule() {}

//------------------------------------------------------------------------------
// operator==
//------------------------------------------------------------------------------
bool RequesterGroupMountRule::operator==(const RequesterGroupMountRule &rhs) const {
  return diskInstance==rhs.diskInstance
    && name==rhs.name
    && mountPolicy==rhs.mountPolicy
    && creationLog==rhs.creationLog
    && lastModificationLog==rhs.lastModificationLog
    && comment==rhs.comment;
}

//------------------------------------------------------------------------------
// operator!=
//------------------------------------------------------------------------------
bool RequesterGroupMountRule::operator!=(const RequesterGroupMountRule &rhs) const {
  return !operator==(rhs);
}

//------------------------------------------------------------------------------
// operator<<
//------------------------------------------------------------------------------
std::ostream &operator<<(std::ostream &os, const RequesterGroupMountRule &obj) {
  os << "(diskInstance=" << obj.diskInstance
     << " name=" << obj.name
     << " mountPolicy=" << obj.mountPolicy
     << " creationLog=" << obj.creationLog
     << " lastModificationLog=" << obj.lastModificationLog
     << " comment=" << obj.comment << ")";
  return os;
}

} // namespace dataStructures
} // namespace common
} // namespace cta
