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

cmake_minimum_required (VERSION 3.17)

find_package(xrootdclient REQUIRED)
find_package(Protobuf3 REQUIRED)

include_directories(${XRD_SSI_PB_DIR}/include ${XROOTD_INCLUDE_DIR} ${XROOTD_INCLUDE_DIR}/private
                    ${CMAKE_BINARY_DIR}/eos_cta
                    ${PROTOBUF3_INCLUDE_DIRS})

# Directory import tool
add_executable(eos-import-dirs EosImportDirsCmd.cpp EosImportDirs.cpp GrpcClient.cpp GrpcUtils.cpp)
target_link_libraries(eos-import-dirs EosMigration ${PROTOBUF3_LIBRARIES} ${GRPC_LIBRARY} ${GRPC_GRPC++_LIBRARY} ctacatalogue)
set_property(TARGET eos-import-dirs APPEND PROPERTY INSTALL_RPATH ${PROTOBUF3_RPATH})
set_property(TARGET eos-import-dirs APPEND PROPERTY INSTALL_RPATH ${ORACLE-INSTANTCLIENT_RPATH})

# File import tool
add_executable(eos-import-files EosImportFilesCmd.cpp EosImportFiles.cpp GrpcClient.cpp GrpcUtils.cpp)
target_link_libraries(eos-import-files EosMigration ${PROTOBUF3_LIBRARIES} ${GRPC_LIBRARY} ${GRPC_GRPC++_LIBRARY} ctacatalogue)
set_property(TARGET eos-import-files APPEND PROPERTY INSTALL_RPATH ${PROTOBUF3_RPATH})
set_property(TARGET eos-import-files APPEND PROPERTY INSTALL_RPATH ${ORACLE-INSTANTCLIENT_RPATH})

# Standalone test tools
#add_executable(grpc-utils-test GrpcUtilsTest.cpp GrpcUtils.cpp)

add_executable(eos-test-dir-inject EosTestDirInject.cpp GrpcClient.cpp GrpcUtils.cpp)
target_link_libraries(eos-test-dir-inject EosMigration ${PROTOBUF3_LIBRARIES} ${GRPC_LIBRARY} ${GRPC_GRPC++_LIBRARY})
set_property(TARGET eos-test-dir-inject APPEND PROPERTY INSTALL_RPATH ${PROTOBUF3_RPATH})

add_executable(eos-test-file-inject EosTestFileInject.cpp GrpcClient.cpp GrpcUtils.cpp)
target_link_libraries(eos-test-file-inject EosMigration ${PROTOBUF3_LIBRARIES} ${GRPC_LIBRARY} ${GRPC_GRPC++_LIBRARY})
set_property(TARGET eos-test-file-inject APPEND PROPERTY INSTALL_RPATH ${PROTOBUF3_RPATH})

install(TARGETS eos-import-dirs
                eos-import-files
                eos-test-dir-inject
                eos-test-file-inject
        DESTINATION usr/bin)
install(FILES ${CMAKE_SOURCE_DIR}/migration/gRPC/json-pretty-print.sh
        DESTINATION usr/bin)
install(FILES ${CMAKE_SOURCE_DIR}/migration/gRPC/castor-migration.conf.example
        DESTINATION etc/cta)
