# terraform

## 1. Basic Knowledge
### 1) Definition
- Infrastructure management tool & language that enables cloud resources (servers, networks, storage) to be managed in code
- Infrastructure management tool & language for IaC

### 2) Role
- Provision infrastructure with a consistent, predictable environment

### 3) Features
- Defined by code
- Declarative language(Declare the final outcome of the infrastructure to be configured)
- agentless
- idempotent


### 4) Basic Terraform Process
```
step1. Write code in terraform file locally
step2. Execute terraform files and apply them to infrastructure
step3. Save state file
```

### 5) Applications (https://registry.terraform.io/browse/providers)
- AWS
- Azure
- GCP
- VMware
- etc.



## 2.  Reference
https://registry.terraform.io

ex1. The doc about aws : https://registry.terraform.io/providers/hashicorp/aws/latest/docs

ex2. The doc about vsphere : https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs


## 3. Files related to Terraform
- .tf : The file implementing IaC through terraform blocks such as provider and resource
- .tfstate : The file about status of resources created through terraform / The file as a result of running terraform
```
cf 1. The state file indicates the state of the resource at the time of tf execution, 
so it does not indicate the real-time current state of the resource

cf 2. Therefore, It's important that the state file matches with the actual infrastructure
```
- terraform.tfvars : The file that stores the actual value of variables in the tf file 
- backend : The remote space to store terraform state files
```
cf. why we use backend : Locking (disallow one person to use what is in use)
```

## 4. Components in Terraform Files
- provider : A module that connects terraform and external services
```
provider "provider name"{
					....
}
```
- resource : the minimum unit of an operable target provided by a particular provider
```
resource "[resource type]" "[localname to use in tf file]"{
  …
}
```
- variable : variables to use in terraforms
```
variable "[variable_name]"{
  Type="" #string, list, hash, etc.
  default = # set default value
}
```
- module : To make common functions available repeatedly
```
module "[Module Name]"{
  ...
}
```
- data : get information provided by infrastructure set by provider
```
data "[resource to reference]" "[data name]"{
  ...
}
```
- output : store the specified value in state as a variable
```
output "[output name]" {
  value = resource factor name
}
```


## 5. Terraform CLI (https://www.terraform.io/docs/cli/)
- init : initialize a working directory containing Terraform configuration files
```
terraform init [options]
```
- plan : create an execution plan
```
terraform plan [options]
```
- apply : execute the tf file
```
terraform apply [options] [plan file]
```
- import : import existing resources into Terraform
```
terraform import [options] ADDRESS ID
```
- state : modify and manage state files
```
terraform state <subcommand(mv, push, pull, rm, etc.)> [options] [args]
``` 
- destory : destroy all remote objects managed by a particular Terraform configuration
```
terraform destroy [options]
```
- show : show files created by terraform
```
terraform show [options] [file]
```
- graph : show the dependencies between resources by graph
```
terraform graph [options]
```

## 6. Terraform Installation
```
$wget [terraform_link]
$unzip [downloaded_terraform_file_name].zip
$sudo mv terraform /usr/local/bin 
```
cf. the link to download file
- The lates version of Terraform files : https://www.terraform.io/downloads.html
- Previous versions of Terraform files : https://releases.hashicorp.com/terraform/


## 7. Advanced Content
Function (https://www.terraform.io/docs/language/functions/index.html)
- Definition : embedded functions to create resources more efficiently and briefly
- Features 
  - It is impossbile to make own function yet
  - Only embedded functions are available 
- Type 
  - numeric functions
  - string functions
  - collection functions
  - encoding functions
  - filesystem functions
  - date and time functions
  - hash and crypto functions
  - IP network functions
  - type conversion functions
