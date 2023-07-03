# - - - - - Terraform Commands - - - - -
init:
	terraform -chdir=./devops init 
validate:
	terraform -chdir=./devops validate
plan:
	terraform -chdir=./devops plan
plan-no-refresh:
	terraform -chdir=./devops plan -refresh=false
apply:
	terraform -chdir=./devops apply
apply-no-refresh:
	terraform -chdir=./devops apply -refresh=false
destroy:
	terraform -chdir=./devops destroy -auto-approve
console:
	terraform -chdir=./devops console
migrate:
	terraform -chdir=./devops init -migrate-state
upgrade:
	terraform -chdir=./devops init -upgrade
reapply:
	make destroy && make apply-no-refresh

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
remote-update-apt:
	cd ./devops && ansible-playbook ./ansible/playbook/remote-update-apt.yaml
master-update-ssh-config:
	cd ./devops && ansible-playbook ./ansible/playbook/master-update-ssh-config.yaml