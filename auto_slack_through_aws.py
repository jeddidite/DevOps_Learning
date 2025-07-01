# Local version of the script to send messages to Slack using a webhook URL.
import os
import requests

WEBHOOK_URL = os.getenv('WEBHOOK_URL')

# Load .env file
if os.path.exists('.env'):
    with open('.env') as f:
        for line in f:
            if '=' in line and not line.startswith('#'):
                key, value = line.strip().split('=', 1)
                os.environ[key] = value

def send_slack_message(message: str):
    payload = {"text": message}  
    try:
        response = requests.post(WEBHOOK_URL, json=payload)
        if response.status_code == 200:
            print(f"Sent: {message}")
        else:
            print("Failed to send message")
    except:
        print("Error sending message")

send_slack_message("test")

# AWS Lambda function to send messages to Slack using a webhook URL.
import json
import urllib.request
import os

WEBHOOK_URL = os.getenv('WEBHOOK_URL')

def send_slack_lambda_message(message: str):
    print(f"Starting send_slack_lambda_message with: '{message}'")
    
    if not WEBHOOK_URL:
        print("No WEBHOOK_URL found!")
        return False
        
    payload = {"text": message}
    print(f"Payload created: {payload}")
    
    try:
        # Convert payload to JSON bytes
        data = json.dumps(payload).encode('utf-8')
        print(f"Data encoded: {data}")
        
        # Create the request
        req = urllib.request.Request(
            WEBHOOK_URL,
            data=data,
            headers={'Content-Type': 'application/json'}
        )
        
        # Send the request
        response = urllib.request.urlopen(req)
        
        if response.status == 200:
            print(f"✅ Sent: {message}")
            return True
        else:
            print(f"❌ Failed to send message. Status code: {response.status}")
            return False
            
    except Exception as e:
        print(f"❌ Error sending message: {str(e)}")
        return False

def lambda_handler(event, context):
    print(f"Event received: {event}")
    
    try:
        if 'body' in event:
            message = event['body']
            print(f"Body found: {message}")
            print(f"About to send message: '{message}'")
            
            # Call the Slack function
            result = send_slack_lambda_message(message)
            print(f"Slack function returned: {result}")
            
            return {
                'statusCode': 200,
                'body': json.dumps('Message sent to Slack!')
            }
        else:
            print("No body in event")
            return {
                'statusCode': 400,
                'body': json.dumps('No message provided')
            }
    except Exception as e:
        print(f"Error in lambda_handler: {str(e)}")
        print(f"Error type: {type(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': f'Internal error: {str(e)}'})
        }