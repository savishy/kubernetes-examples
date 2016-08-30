This example sets up a Kubernetes cluster in AWS using Ansible.


## Prerequisites

1. Install `python-netaddr` (e.g. `apt-get install python-netaddr`). This is
   required for the role
   [`ansible-kubernetes`](https://github.com/kubernetes/contrib/tree/master/ansible#before-starting).



## Troubleshooting

### "`No such file or directory: ansible/meta/.galaxy_install_info`"

```
ERROR! Unexpected Exception: [Errno 2] No such file or directory:
'... node-kube-docker-aws-ansible/roles/ansible/meta/.galaxy_install_info'
```

This usually means the Ansible role being installed does not have a meta
folder in the specified location, i.e it's not in the ansible-galaxy format.

Usually the fix is to add a top-level meta folder, or create folder structure
using `ansible-galaxy init`.

