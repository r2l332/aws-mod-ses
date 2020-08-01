import os, json
import boto3
from botocore.exceptions import ClientError

ses = boto3.client('sesv2', region_name='eu-west-1')

def lambda_handler(event, context):
    # Main function
    try:
        # Load event data into variable
        email_message_load     = json.loads(event['Records'][0]['Sns']['Message'])
        # Use Python os library to retrieve environment variables - email_change is used
        email_sender           = "From: " + os.environ['tlz_sender']
        return_sender          = "Return-Path: " + os.environ['tlz_sender']
        # Extract content from event
        message_extraction     = email_message_load['content']
        # Access content to extract Return-Path, From field and DKIM-Signature
        for item in message_extraction.split("\n"):
            if "From: " in item:
                original_sender = item.strip()
            if "Return-Path: " in item:
                return_path = item.strip()

        if "DKIM-Signature: " in message_extraction:
            dkim_sig = re.findall(r'DKIM-Signature:(.+?)From: ', message_extraction)
            item = ''.join(dkim_sig)
            dkim_sig = message_extraction.replace(item, "", 2)
            message_extraction = message_extraction.replace("DKIM-Signature:", "", 1)
        # Strip To and Return-Path fields from original headers.
        orig_sender_format            = message_extraction.replace(original_sender, email_sender, 1)
        return_path_format            = orig_sender_format.replace(return_path, return_sender, 1)      
        # Set content to bytes for raw data sending.
        email_body             = return_path_format.encode("utf-8")
        # Trigger SES publish function
        lambda_publish_ses(email_body)
    except ClientError as e:
        body = f"Unexpected error : {e}"
        print(body)
        raise e
        
def lambda_publish_ses(email_body):
    # Extract environment variable to use for email sending
    tlz_receiver = os.environ['tlz_receiver']
    # Use SES send_raw_email uses original payload
    response = ses.send_email(
        Destination={
            'ToAddresses': [
                tlz_receiver,
            ]
        },
        Content={
            'Raw': {
                'Data': email_body
                }
            }
        )
       
if __name__ == "__main__":
    lambda_handler(event, __)