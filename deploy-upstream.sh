#!/bin/bash -e

# Copyright(c) 2017-2021 CloudNetEngine. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TEST_ROOT="$PWD/../../../TEST_ROOT"
TEST_SRC_DIR="${TEST_ROOT}/src"
TEST_BIN_DIR="${TEST_ROOT}/bin"

OVS_SRC_NAME="ovs"
OVS_DIR="${TEST_SRC_DIR}/${OVS_SRC_NAME}"

cd ${TEST_SRC_DIR}

cd $OVS_DIR
git checkout .
git checkout 1d8e0f861f7fb21bd33a374ff031ee042b0485a6

git clean -f -d
./boot.sh
./configure --disable-ssl --with-dpdk=static --with-logdir=/var/log/openvswitch --with-rundir=/var/run/openvswitch CFLAGS=" -Ofast -msse4.2 -mpopcnt "

# Build OVS
make -j4
OVS_BIN_DIR="${TEST_BIN_DIR}/openvswitch"
rm -rf ${OVS_BIN_DIR}
rm -rf "${TEST_BIN_DIR}/ovs-native"
rm -rf "${TEST_BIN_DIR}/ovs-dpdk"
mkdir -p ${OVS_BIN_DIR}
cp ./utilities/ovs-dpctl ${OVS_BIN_DIR}
cp ./utilities/ovs-appctl ${OVS_BIN_DIR}
cp ./utilities/ovs-ofctl ${OVS_BIN_DIR}
cp ./utilities/ovs-vsctl ${OVS_BIN_DIR}
cp ./vswitchd/ovs-vswitchd ${OVS_BIN_DIR}
cp ./ovsdb/ovsdb-server ${OVS_BIN_DIR}
cp ./vswitchd/vswitch.ovsschema ${OVS_BIN_DIR}
cp ./ovsdb/ovsdb-tool ${OVS_BIN_DIR}

ln -s ${OVS_BIN_DIR} "${TEST_BIN_DIR}/ovs-native"
ln -s ${OVS_BIN_DIR} "${TEST_BIN_DIR}/ovs-dpdk"
