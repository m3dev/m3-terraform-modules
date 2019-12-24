#!/usr/bin/python

from botocore.vendored import requests # https://stackoverflow.com/a/48495770
import json
import os
import logging

webhook_url = os.environ['slack']
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
def lambda_hander(event, context):
    logger.info(json.dumps(event))

    for record in event['Records']:
        process_event(json.loads(record['Sns']['Message']))

def process_event(event):
    event_detail = {}
    if 'detail' in event:
        event_detail = event['detail']
    account = ""
    if 'account' in event:
        account = event['account']
    event_service = {}
    if 'service' in event_detail:
        event_service = event_detail['service']
    
    message = "{title}\n{description}\nnseverity: {severity}\neventFirstSeen: {eventFirstSeen}\nregion: {region}\naccount: {account}".format(
        title = event_detail.get('title'),
        description = event_detail.get('description'),
        severity = event_detail.get('severity'),
        eventFirstSeen = event_service.get('eventFirstSeen'),
        region = event.get('region'),
        account = account,
    )
    if event['detail']['severity'] > 3.9:
        requests.post(webhook_url, data = json.dumps({
            'text': message,
            'username': 'GuardDuty',
            'icon_emoji': ':rotating_light:',
            'link_names': 1,
        }))
