#!/usr/bin/env bash

#
# @Gokula Adabala <gokula.adabala@gmail.com>
# Creates an image (AMI) of the given EC2 instance
# Jenkins will run this job daily as per schedule
#
# This Script will create image for DEV-DB and deletes the image which was 2 days old
#
export AWS_PROFILE=default
DATE=$(date +%Y-%m-%d)
AMI_NAME="ServerName - $DATE"
AMI_DESCRIPTION="ToolsServer Backup - $DATE"
INSTANCE_ID=$1
printf "Requesting AMI for instance $1...\n"
AMI_ID=$(aws ec2 create-image --instance-id $INSTANCE_ID --name $AMI_NAME --description "$AMI_DESCRIPTION" --no-reboot | jq -r ".ImageId")
#AMI_ID=$(aws ec2 create-image --instance-id $INSTANCE_ID --name $AMI_NAME --description "$AMI_DESCRIPTION" --no-reboot |  awk '{print $2}')
#AMI_ID="${opt%\"}"
#AMI_ID="${AMI_ID#\"}"
        if [ $? -eq 0 ];
                then
                        printf "AMI request complete!\n"
                        # sleep
                        aws ec2 create-tags --resources $AMI_ID --tags Key=Instance_id,Value=$INSTANCE_ID Key=Date,Value=$DATE
                else
                        printf "AMI Creation wasnot complete successfully\n"
        fi

printf "Getting Old Images\n"
DATE_OLD=$(date +%Y-%m-%d --date '2 days ago')
AMI_NAME_OLD="DEV-DB - $DATE_OLD"
printf "Finding the image to remove\n"
AMI_ID_OLD=$(aws ec2 describe-images --filters Name=name,Values="$AMI_NAME_OLD" Name=tag-key,Values=Instance_id Name=tag-value,Values="$INSTANCE_ID" --query "Images[*].{ID:ImageId}" --output text)

    if [ $# -eq 0 ];
               then

                        printf "Finding the image to remove\n"
                        #AMI_ID_OLD=$(aws ec2 describe-images --filters Name=name,Values="$AMI_NAME_OLD" Name=tag-key,Values=INSTANCE_ID Name=tag-value,Values="$INSTANCE_ID" --query "Images[*].{ID:ImageId}" --output text)
                        printf "Find the snapshot attached to the AMI need to be Deregister\n"
                        #aws ec2 describe-images --image-ids $AMI_ID_OLD --query "Images[].BlockDeviceMappings[].Ebs.SnapshotId" --output text

                        printf "Deregistering the AMI\n"
                        aws ec2 deregister-image --image-id "$AMI_ID_OLD"
                else

                        printf "No Old Image was found\n"

   fi