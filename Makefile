# - - - - - Terraform Commands - - - - -
init:
	terraform -chdir=./devops init 
plan:
	terraform -chdir=./devops plan
apply:
	terraform -chdir=./devops apply
destroy:
	terraform -chdir=./devops destroy -auto-approve
console:
	terraform -chdir=./devops console
migrate:
	terraform -chdir=./devops init -migrate-state

# - - - - - Ansible Commands - - - - -
# Ping
ping:
	cd ./devops && ansible all -m ping
ping-master:
	cd ./devops && ansible master -m ping
ping-nodes:
	cd ./devops && ansible master -m ping

# Check Version
version:
	cd ./devops && ansible all -m shell -a "lsb_release -a"
version-master:
	cd ./devops && ansible master -m shell -a "lsb_release -a"
version-nodes:
	cd ./devops && ansible nodes -m shell -a "lsb_release -a"

inventory:
	cd ./devops && ansible-inventory --graph --vars 

# Playbook
local-update-ssh-config:
	cd ./devops && ansible-playbook ./ansible/playbook/local-update-ssh-config.yaml
update-apt:
	cd ./devops && ansible-playbook ./ansible/playbook/update-apt.yaml