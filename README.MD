**Nicolas M. Morillo Martinez**

> Disclaimer || The user should already have aws access configurated to avoid hardcoding sensitive data into the state file. 

## EC2 
 The AWS infrastructue, have his principal focus in deploy 2 instances  by the **ec2.tf** file , following the rules difined within the file. In this case, the infrastructure hasn't a faileover solution to for any instances issue.

in this case, 2 ec2 instance are deployed directly by the ec2.tf file, without any failover solution.

| Permissions | 
    | ------ |
    | S3|
    | DyanmoDB|
    | VPC|
    | EC2|
    | IAM|


The AWS region selected is **us-east-1** to the backend and all the resources.

Before deploying the infrastructure we need to have a **S3 bucket** created to use it as the backend. With the s3 bucket already created, change the value of the bucket name in the file ``backend.conf`` for your bucket name, to set the backend s3 bucket.

## _**Deploy:**_

__Initiate__ and __run__ the dybamodb resource to keep lock our state for all operation that could write state.


1. Initiate terraform in dynamo-lock folder:
```sh
  terraform -chdir="dynamo-lock" init -backend-config=../backend.conf
 ```
2. Run apply to create the dynamo-lock table:
```sh
 terraform -chdir="./dynamo-lock" apply 
```
__Initiate__ and __run__ the infrastructure, obtaining in the console the __load balancer dns name__

3. Initiate terraform in deploy folder:
```sh
 terraform -chdir="deploy" init -backend-config=../backend.conf
```
4. Run apply to deploy all the resources:
```sh
  terraform -chdir="deploy" apply
```

## _**Test:**_

With the __load balancer dns name__, open your browser and check the page.


## _**Destroy all infrastructure:**_
```sh
terraform -chdir="./dynamo-lock" destroy -auto-approve

terraform -chdir="deploy" destroy -auto-approve
```