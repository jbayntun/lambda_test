import os
import boto3
import json
from PIL import Image
from io import BytesIO

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    
    # Get bucket name and file key from the event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Get the image file from S3
    image_object = s3_client.get_object(Bucket=bucket, Key=key)
    image = Image.open(BytesIO(image_object['Body'].read()))
    
    # Resize the image
    image = image.resize((128, 128), Image.ANTIALIAS)
    
    # Save the image to a BytesIO object
    resized_image = BytesIO()
    image.save(resized_image, 'JPEG')
    resized_image.seek(0)
    
    # Upload the resized image back to S3
    new_key = 'resized/' + os.path.basename(key)
    s3_client.put_object(Body=resized_image, Bucket=bucket, Key=new_key, ContentType='image/jpeg')
    
    return {
        'statusCode': 200,
        'body': json.dumps('Image resized and saved!')
    }
