import boto3
import time

# Create SQS client
sqs = boto3.client('sqs')

queue_url = 'https://sqs.us-east-1.amazonaws.com/703347463263/ben-test-b-queue'

while True:
    # Receive message from SQS queue
    response = sqs.receive_message(
        QueueUrl=queue_url,
        AttributeNames=[
            'SentTimestamp'
        ],
        MaxNumberOfMessages=1,
        MessageAttributeNames=[
            'All'
        ],
        VisibilityTimeout=0,
        WaitTimeSeconds=0
    )

    if 'Messages' not in response:
        time.sleep(3)
        continue

    message = response['Messages'][0]
    receipt_handle = message['ReceiptHandle']

    # Delete received message from queue
    sqs.delete_message(
        QueueUrl=queue_url,
        ReceiptHandle=receipt_handle
    )
    print('Received and deleted message: %s' % message)