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

#pragma once

#include "TapeFseqRange.hpp"

#include <list>

namespace cta {
namespace tapeserver {
namespace readtp {

/**
 * Generates a sequence of tape file sequence numbers from a range of tape file
 * sequence numbers.
 */
class TapeFseqRangeSequence {
public:

  /**
   * Constructor.
   *
   * Constructs an empty sequence.
   */
  TapeFseqRangeSequence() throw();

  /**
   * Constructor.
   *
   * @param range The range from which the sequence is generated.
   */
  TapeFseqRangeSequence(const TapeFseqRange &range) throw();

  /**
   * Resets the sequence to empty.
   */
  void reset() throw();

  /**
   * Resets the sequence using the specified range.
   *
   * @param range The range from which the sequence is generated.
   */
  void reset(const TapeFseqRange &range) throw();

  /**
   * Returns true if there is another tape file sequence number in the
   * sequence.
   */
  bool hasMore() const throw();

  /**
   * Returns the next tape file sequence number in the sequence, or throws
   * NoValue exception if there isn't one.
   */
  uint32_t next() ;

  /**
   * Returns the number of values generated by the sequence so far.
   */
  uint32_t nbGeneratedValues() const throw();

  /**
   * Returns the range used by this sequence.
   */
  const TapeFseqRange &range() const throw();


private:

  /**
   * The range from which the sequence is generated.
   */
  TapeFseqRange m_range;

  /**
   * The value to be returned by a call to next().
   */
  uint32_t m_next;

}; // class TapeFseqRangeSequence

} // namespace readtp
} // namespace tapeserver
} // namespace cta