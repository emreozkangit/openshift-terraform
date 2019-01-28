Openshift 3.11  OKD installiation with Terraform


export AWS_ACCESS_KEY_ID='**'

export AWS_SECRET_ACCESS_KEY='zcY/hur+****+'

export TF_VAR_email='cloudfare login '

export TF_VAR_token='token'

export TF_VAR_domain='emreozkan.host'

export TF_VAR_htpasswd='demo'

-----
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ./helper_scripts/id_rsa -r ./helper_scripts/id_rsa ec2-user@$(terraform output bastion):/home/ec2-user/.ssh/

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ./helper_scripts/id_rsa -r ./inventory/ansible-hosts  ec2-user@$(terraform output bastion):/home/ec2-user/ansible-hosts


ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ./helper_scripts/id_rsa -l ec2-user $(terraform output bastion) -A "cd /openshift-ansible/ && ansible-playbook ./playbooks/openshift-pre.yml -i ~/ansible-hosts"

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ./helper_scripts/id_rsa -l ec2-user $(terraform output bastion) -A "cd /openshift-ansible/ && ansible-playbook ./playbooks/openshift-install.yml -i ~/ansible-hosts"
