import os.path
import sys
import json
from yaml import safe_load as yaml_load
import boto3


def main():    
    yml_title = "ec2_config.yml"
    json_title = "ec2_config.json"

    json_config_exists = os.path.isfile(json_title)
    yaml_config_exists = os.path.isfile(yml_title)

    config = {}

    if json_config_exists:
        with open(json_title) as json_file:
            config = json.load(json_file)
    elif yaml_config_exists:
        with open(yml_title) as yml_file:
            config = yaml_load(yml_file)
    else:
        sys.exit("No config file found: checked for ec2_config.json or ec2_config.yml")

    if config.get("Instances"):
        instances_info = config.get("Instances")
        ec2 = boto3.client('ec2')
        for instance_info in instances_info:
            ami = instance_info["ami-id"]
            instance_tags = instance_info["tags"]
            tags = []

            for dict in instance_tags:
                for key in dict.keys():
                    res = {"Key": key, "Value": dict[key] }
                    tags.append(res)
            
            tag_spec = [{"ResourceType": "instance", "Tags": tags}]
            instance_type = instance_info["instance-type"]

            if instance_type.startswith("t2"):
                print("WARNING: You use old instance type - {}".format(instance_type))

            instance = ec2.run_instances(InstanceType=instance_type, ImageId=ami, TagSpecifications=tag_spec, MaxCount=1, MinCount=1)
            
    else:
        sys.exit("Incorrect config: Instances not specified")


if __name__ == "__main__":
    # execute only if run as a script
    main()