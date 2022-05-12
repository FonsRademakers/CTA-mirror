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

#include "scheduler/SchedulerDatabase.hpp"

namespace cta {

//------------------------------------------------------------------------------
// destructor
//------------------------------------------------------------------------------
cta::SchedulerDatabase::~SchedulerDatabase() throw() { }

SchedulerDatabase::RepackRequestStatistics::RepackRequestStatistics() {
  typedef common::dataStructures::RepackInfo::Status Status;
  for (auto & s: {Status::Complete, Status::Failed, Status::Pending, 
      Status::Running, Status::Starting, Status::ToExpand})
    operator [](s) = 0;
}

void SchedulerDatabase::DiskSpaceReservationRequest::addRequest(const std::string& diskSystemName, uint64_t size) {
  try {
    at(diskSystemName) += size;
  } catch (std::out_of_range &) {
    operator[](diskSystemName) = size;
  }
}


} //namespace cta
