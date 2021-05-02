# Work in Progress

Get the tool (tf code, scripts, etc). Via `git clone`, for example.

### Dependencies
[Terraform](http://www.terraform.io/downloads.html) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). The following docker image has all dependencies installed:

```
cd PROJECT_FOLDER && \
  docker run -it --rm -v $(pwd):/host/cloud-tools -v ~/.aws/:/home/cracker/.aws/:ro claudioandre/john-cloud-tools
```
Hint: create an alias for the command.

### AWS Credentials Profile
Create your [AWS profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

Example `~/.aws/credentials`
```
[cracker]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

### Tune it to your use case
You need to open and edit the file `variables.tf`.

1. Find your public IP adress using, for instance, https://www.myip.com/
   Update the `cidr_blocks inside` session `variable "ingress_data"` in `variable.tf`.
2. You can also make adjustments to `variable "regions_list"`.

## Key and server
You can use your own ssh keys or create new ones. You will use the ssh keys only during your cracking session, so it can be disposable. Do NOT use a passphrase to create it.
```
ssh-keygen -t rsa -f jtr-workerKey
```

## Example (Something I really did)

```
# To create a sample hashes.txt
john --list=format-tests 2> /dev/null | cut -f3 1> hashes.txt

# Get the tool
git clone https://github.com/openwall/john-packages.git cloud-tools
cd  cloud-tools

# The `-v` is to share content between host and Docker (Bind-mount a directory inside Docker)
#   Current (project) folder   -v $(pwd):/host/cloud-tools
#   AWS credentials            -v ~/.aws/:/home/cracker/.aws/:ro

docker run -it --rm -v $(pwd):/host/cloud-tools -v ~/.aws/:/home/cracker/.aws/:ro claudioandre/john-cloud-tools

# Create disposable SSH credentials (to use inside docker).
# You will not lose the key, it will be saved on the host machine due to Bind-mount (-v).
#   Do NOT use a passphrase.
ssh-keygen -t rsa -f jtr-workerKey

# If you have not created and linked your AWS credentials for use in Docker, create them now.
terraform init
terraform workspace list
terraform apply

# The `terraform apply` will print the remote IP address(es). Use it(them) to connect to the new instance(s):
ssh -i jtr-workerKey ubuntu@34.230.75.137

# The Ansible `inventory` file was created. In my example it is:
[Crackers]
ec2-34-230-75-137.compute-1.amazonaws.com ansible_host=34.230.75.137 # i-02af3fe760c36281b

# Copy hashes to all requested remote servers:
ansible-playbook -i inventory --private-key=jtr-workerKey playbook/copy-hashes.yml

# Build JtR in all requested remote servers:
ansible-playbook -i inventory --private-key=jtr-workerKey playbook/install-john.yml

# Use ansible to get `build-info` from all running instances:
ansible --private-key jtr-workerKey -u ubuntu -i inventory -a "john/run/john --list=build-info" all

# Use ansible to run the same cracking session in all instances:
ansible all -i inventory --private-key jtr-workerKey -u ubuntu -B 1800 -P 0 -a "john/run/john -form:md5crypt ~/hashes.txt"

# Get the status of john from all running instances:
ansible all -i inventory --private-key jtr-workerKey -u ubuntu -a "john/run/john -status"

# Show cracked passwords in all running instances:
ansible all -i inventory --private-key jtr-workerKey -u ubuntu -a "john/run/john --show ~/hashes.txt -form:md5crypt"
== Output ==
ec2-34-230-75-137.compute-1.amazonaws.com | CHANGED | rc=0 >>
?:12345
?:test
[...]
?:aaaaaaaa
?:aaaaaaaaaaaa

48 password hashes cracked, 54 left

# Copy back cracked passwords in all running instances:
ansible-playbook -i inventory --private-key=jtr-workerKey playbook/copy-back.yml

# Do some tests then destroy the infrastructure created below (to avoid costs).
terraform destroy
```