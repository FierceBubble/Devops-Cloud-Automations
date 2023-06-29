# - - - - - Terraform Commands - - - - -
init:
	terraform -chdir=./devops init --backend-config=backend
plan:
	terraform -chdir=./devops plan
apply:
	terraform -chdir=./devops apply
destroy:
	terraform -chdir=./devops destroy -auto-approve
console:
	terraform -chdir=./devops console
# - - - - - Ansible Commands - - - - -
# Ping
ping:
	ansible all -m ping
ping-master:
	ansible master -m ping
ping-nodes:
	ansible master -m ping

# Check Version
version:
	ansible all -m shell -a "lsb_release -a"
version-master:
	ansible master -m shell -a "lsb_release -a"
version-nodes:
	ansible nodes -m shell -a "lsb_release -a"