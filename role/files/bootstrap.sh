#!/usr/bin/env sh

DEBUG=1

[ -z ${env} ] && { echo "Failed to load the env variable."; exit 1; }

ANSIBLE_PLAYBOOK_DIR="/tmp/ansible"
BINYUM="/usr/bin/yum"

sudo ${BINYUM} repolist
sudo ${BINYUM} makecache
sudo ${BINYUM} -y install epel-release 

# Installing fixed version due an error in the ProxySQL Project to integrate with the Ansible 2.9. It will be fixed in the future
#sudo ${BINYUM} -y install ansible
sudo ${BINYUM} -y erase ansible
sudo ${BINYUM} -y install https://cbs.centos.org/kojifiles/packages/ansible/2.8.1/1.el7/noarch/ansible-2.8.1-1.el7.noarch.rpm

if [ ${DEBUG} -eq 1 ] ; then
    sudo ansible-playbook -vvvv ${ANSIBLE_PLAYBOOK_DIR}/main.yml --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/vars/${env}.vars" --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/vars/general.vars"
else
    sudo ansible-playbook ${ANSIBLE_PLAYBOOK_DIR}/main.yml --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/vars/${env}.vars" --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/vars/general.vars"
fi
