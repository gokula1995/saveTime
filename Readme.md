### To create the AMI of the Server

Before running this script. Set your aws profile in your machine,

Run the below command with instance id which you want to take backup
```
sh instane_ami.sh <instance id>
```


### TO Shutdown the servers to save money which are in autoscaling mode
To shutdown the servers which are in autoscaling mode

Before running the below script, set your aws profile in your machine.

Make sure that python has been installed in yout machine

```
python shutdown.py EC2ContainerService-SAMPLE-DEMO-EcsInstanceAsg-KJSFAJHF dev 1 1
```
In the above command 
"EC2ContainerService-SAMPLE-DEMO-EcsInstanceAsg-KJSFAJHF" is AutoScaling Group Name 
dev is AWS_PROFILE 
1 minimum instances 
1 desired instances

python shutdown.py {autoScalingGroupName} {aws_profile} {min_size} {desired_capacity}
