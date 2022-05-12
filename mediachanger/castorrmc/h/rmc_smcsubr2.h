/*
 * @project      The CERN Tape Archive (CTA)
 * @copyright    Copyright © 1998-2022 CERN
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

#pragma once

#include "osdep.h"
#include "smc_struct.h"

EXTERN_C int smc_dismount (
  const int rpfd,
  const int fd,
  const char *const loader,
  struct robot_info *const robot_info,
  const int drvord,
  const char *const vid);

EXTERN_C int smc_export (
  const int rpfd,
  const int fd,
  const char *const loader,
  struct robot_info *const robot_info,
  const char *const vid);

EXTERN_C int smc_import (
  const int rpfd,
  const int fd,
  const char *const loader,
  struct robot_info *const robot_info,
  const char *const vid);

EXTERN_C int smc_mount (
  const int rpfd,
  const int fd,
  const char *const loader,
  struct robot_info *const robot_info,
  const int drvord,
  const char *const vid,
  const int invert);
