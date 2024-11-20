# Cloud Automation

Get the tool (Terraform code, scripts, etc). Via `git clone`, for example.

The default settings of this tool perform actions on AWS that are eligible for the free tier. Therefore, you can try it
out on a new AWS account for free.

Note that you may create resources which cost money. Run `terraform destroy` when you no longer need those resources.

## Use Cases

It is useful for provisioning and destroying instances: it is fast, repeatable and reduces the risk of human error.
There is no possibility to forget to delete an instance or the EBS disk. It makes sense if someone wants to start a few
instances and try a wordlist here, or a mask there, maybe incremental over there.

- you provision all instances at once;
- use can use SSH to perform your intended test on each instance;
- obtain the status of all instances at once;
- when you're done, destroy everything you've created locally using just one command.

With the tool, it is feasible that someone can safely run a cracking session that lasts for weeks on the free tier.

IMPORTANT: The total cost of your cracking sessions on AWS will vary depending on your usage and whether you are outside
the AWS Free Tier limits.

### Dependencies

[Terraform](http://www.terraform.io/downloads.html) and
[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). The following docker
image has all dependencies installed:

```bash
cd PROJECT_FOLDER && \
  docker run -it --rm -v $(pwd):/host/workdir -v ~/.aws/:/home/usr/.aws/:ro claudioandre/cloud-tool
```

Hint: create an alias for the command.

### AWS Credentials Profile

Create your [AWS profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

### Adjust it to your use case

You need to open and edit the file `variables.tf`.

1. Find your public IP address using, for instance, [https://www.myip.com/](https://www.myip.com/). Update the
   `cidr_blocks inside` session `variable "ingress_data"` in `variable.tf`.
2. You can also make adjustments to `variable "regions_list"`.

## Key and server

You can use your own SSH keys or create new ones. You will use the SSH keys only during your cracking session, so it can
be disposable. Do NOT use a passphrase to create it.

```bash
ssh-keygen -t rsa -f workerKey
# key was created
```

## Example (Something I really did)

```bash
# Get the tool
git clone https://github.com/openwall/john-packages.git cloud
cd  cloud/cloud-tool

##                    IMPORTANT                    ##
# Edit the `variables.tf` file and update it with your *public* IP address (search for 'YOUR_IP_HERE').

# Create your hashes.txt file (an example file already exists in the project directory).
john --list=format-tests 2> /dev/null | cut -f3 1> hashes.txt

# The `-v` is to share content between host and Docker (Bind-mount a directory inside Docker)
#   Current (project) folder   -v $(pwd):/host/workdir
#   AWS credentials            -v ~/.aws/:/home/usr/.aws/:ro

docker run -it --rm -v $(pwd):/host/workdir -v ~/.aws/:/home/usr/.aws/:ro claudioandre/cloud-tool

# Create disposable SSH credentials (to use inside docker).
# You will not lose the key, it will be saved on the host machine due to Bind-mount (-v).
#   Do NOT use a passphrase.
ssh-keygen -t rsa -f workerKey

# If you have not created and linked your AWS credentials for use in Docker, create them now.
terraform init
terraform workspace list
terraform apply

# The `terraform apply` will print the remote IP address(es). Use it(them) to connect to the new instance(s):
# In my case it is: ssh -i workerKey ubuntu@34.230.75.137
ssh -i workerKey ubuntu@REMOTE_IP_HERE

# The Ansible `inventory` file was created. In my example it is:
[Crackers]
ec2-34-230-75-137.compute-1.amazonaws.com ansible_host=34.230.75.137 # i-02af3fe760c36281b

# Copy hashes to all requested remote servers:
ansible-playbook -i inventory --private-key=workerKey playbook/copy-hashes.yml

# Build JtR in all requested remote servers:
ansible-playbook -i inventory --private-key=workerKey playbook/install-john.yml

# Use ansible to get `build-info` from all running instances:
ansible --private-key workerKey -u ubuntu -i inventory -a "john/run/john --list=build-info" all

# Use ansible to run the same cracking session in all instances:
ansible all -i inventory --private-key workerKey -u ubuntu -B 1800 -P 0 -a "john/run/john --format:md5crypt ~/hashes.txt"

# Get the status of john from all running instances:
ansible all -i inventory --private-key workerKey -u ubuntu -a "john/run/john -status"

# Show cracked passwords in all running instances:
ansible all -i inventory --private-key workerKey -u ubuntu -a "john/run/john --show ~/hashes.txt --format:md5crypt"
== Output ==
ec2-34-230-75-137.compute-1.amazonaws.com | CHANGED | rc=0 >>
?:12345
?:test
[...]
?:aaaaaaaa
?:aaaaaaaaaaaa

48 password hashes cracked, 54 left

# Copy cracked passwords from all running instances back:
ansible-playbook -i inventory --private-key=workerKey playbook/copy-back.yml

# Do some tests then destroy the infrastructure created below (to avoid costs).
terraform destroy
```

## Usage of Spot Instances

If you want to run cheaper Spot instances, you should specify this on your command-line (or edit the `variables.tf`
file, of course).

```bash
$ terraform plan  --var "spot=yes" --var "spot_price=0.23"  # today's price for a g3s.xlarge
# Command output

$ terraform apply --var "spot=yes" --var "spot_price=0.23"
# Command output
```

If you need information about Spot pricing, please visit:

- [https://aws.amazon.com/ec2/spot/pricing/?nc1=h_ls](https://aws.amazon.com/ec2/spot/pricing/?nc1=h_ls)
- Also, there is a Pricing history button at
  [https://console.aws.amazon.com/ec2sp/v2/home?region=us-east-1#/spot](https://console.aws.amazon.com/ec2sp/v2/home?region=us-east-1#/spot)
  where you can see a nice "Spot Instance pricing history" graphic.

Remember that your instance can be stopped by Amazon at any time.
