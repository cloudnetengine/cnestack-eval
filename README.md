# Welcome to Evaluate CNEStack 3.0 !
   NOTE: When using CNEStack 3.0 binary, you are assumed to accept the
         evaluation license in ``CNEStack_3.0_evaluation_license_agreement.txt``.

   This repo provides CNEStack 3.0 binary and scripts to integrate CNEStack
   with upstream OVS-DPDK.

## Get Started

### Preparation

* Setup cne-ovs-sit management node and SUT nodes by referencing
   [cne-ovs-sit quick start](https://github.com/cloudnetengine/cne-ovs-sit/blob/master/docs/quick_start.rst).

* On each SUT, clone this repo under directory ``TEST_ROOT/src/`` with name
   cnestack-eval.

```
NOTE: Be sure to connect the two SUT nodes by 25G or 40G links,
         otherwise the physical network might be a bottleneck.
```

### Evaluate performance of OVS-DPDK integrated with CNEStack

* On each SUT, execute ```deploy-cnestack.sh``` to build OVS-DPDK with CNEStack.

* On management node, customize your topology file
  ```topologies/enabled/my.yaml```.
```
   NOTE: Be sure "userspace_tso" option is NOT explicitly set or is "True" in
         in topology config yaml file.
```

* On management node, create a new testenv named ```my_env``` in ```tox.ini```,
  e.g.

```
[testenv:my_env]
basepython=python3.8
deps = -r{toxinidir}/requirements.txt
setenv = PYTHONPATH=.
commands =
    robot -L TRACE -v TOPOLOGY_PATH:topologies/enabled/my.yaml --include PERFANDVXLAN tests/
```

* On management node, execute ``tox -e my_env`` to do VXLAN performance evaluation.


### Evaluate performance of upstream OVS-DPDK

* On each SUT, execute ```deploy-upstream.sh``` to build upstream OVS-DPDK.

* On management node, customize your topology file
  ```topologies/enabled/my.yaml```.
```
   NOTE: "userspace_tso" option MUST be "False" for all two SUTs,
         please refer to topologies/enabled/i40e-tsooff.yaml as an example.
```

* On management node, execute ``tox -e my_env`` to do performance evaluation.

## Contact
   info@cloudnetengine.com
