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
apply-auto-approve:
	terraform -chdir=./devops apply -refresh=false -auto-approve
destroy:
	terraform -chdir=./devops destroy -auto-approve
console:
	terraform -chdir=./devops console
migrate:
	terraform -chdir=./devops init -migrate-state
upgrade:
	terraform -chdir=./devops init -upgrade
reapply:
	$(MAKE) destroy && $(MAKE) apply-auto-approve

# - - - - - Ansible Commands - - - - -
## Inventory
inventory:
	cd ./devops && ansible-inventory --graph --vars 

## Ping
ping:
	cd ./devops && ansible all -m ping
ping-master:
	cd ./devops && ansible master -m ping
ping-worker:
	cd ./devops && ansible worker -m ping

##Check Version
version:
	cd ./devops && ansible all -m shell -a "lsb_release -a"
version-master:
	cd ./devops && ansible master -m shell -a "lsb_release -a"
version-nodes:
	cd ./devops && ansible nodes -m shell -a "lsb_release -a"

## Playbook
local-update-ssh-config:
	cd ./devops && ansible-playbook ./ansible/playbook/local-update-ssh-config.yaml
local-add-kubeconfig:
	cd ./devops && ansible-playbook ./ansible/playbook/local-add-kubeconfig.yaml

master-update-apt:
	cd ./devops && ansible-playbook ./ansible/playbook/master-update-apt.yaml
master-update-ssh-config:
	cd ./devops && ansible-playbook ./ansible/playbook/master-update-ssh-config.yaml

worker-update-apt:
	cd ./devops && ansible-playbook ./ansible/playbook/worker-update-apt.yaml

all-update-apt:
	cd ./devops && ansible-playbook ./ansible/playbook/all-update-apt.yaml

kubernetes-init:
	cd ./devops && ansible-playbook ./ansible/playbook/kubernetes-init.yaml