import json
import logging
import os

import boto3


class JsonFormatter:
    def format(self, record):
        return json.dumps(record.__dict__)


logging.basicConfig()
logging.getLogger().handlers[0].setFormatter(JsonFormatter())
logger = logging.getLogger(__name__)
logger.setLevel(os.environ.get('LOG_LEVEL', 'INFO'))


def lambda_handler(event, context):
    try:
        service = os.environ['EcsServiceArn']
        cluster = os.environ['EcsClusterName']
    except KeyError as e:
        logger.exception(f'Environment variable not set: {e}')
        raise

    client = boto3.client("ecs")
    response = client.update_service(
        cluster=cluster,
        service=service,
        forceNewDeployment=True,
    )
