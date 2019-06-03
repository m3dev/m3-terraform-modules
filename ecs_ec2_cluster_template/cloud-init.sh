# Join to ECS cluster
echo ECS_CLUSTER=${ecs_cluster_id} >> /etc/ecs/ecs.config

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ec2-run-command.html#install_ssm_agent
yum install -y amazon-ssm-agent
start amazon-ssm-agent || true
status amazon-ssm-agent || true
