import json
import boto3
UserName = 'datauser3'
iam = boto3.client("iam")
sns = boto3.client('sns', region_name='us-east-1')

#Listing the exist keys

def ListKey(UserName):
    ListKey = iam.list_access_keys(
        UserName = UserName
    )
    OldAccessKey = ListKey['AccessKeyMetadata'][0]['AccessKeyId']
    print('\n')
    return OldAccessKey

#delete existing Access key 

def DeleteKey(OldAccessKey,UserName):
    DeleteKey = iam.delete_access_key(
        AccessKeyId = OldAccessKey,
        UserName = UserName
    )

#Create the New AccessKey and SecretKey

def CreateKey(UserName):
    CreateKey = iam.create_access_key(
        UserName=UserName
    )
    NewAccessKey = CreateKey['AccessKey']['AccessKeyId']
    NewSecretAccessKey = CreateKey['AccessKey']['SecretAccessKey']
    return NewAccessKey, NewSecretAccessKey

# Send SNS notification to user

def SnsPublish(AccessKey,SecretKey,UserName):
    TargetArn = 'arn:aws:sns:us-east-1:941598205732:sns101'
    SendResponse = sns.publish(
        TargetArn = TargetArn,
        Message = "Hi {}, This is your new Access key {} and SecretKey {}".format(UserName,AccessKey,SecretKey),
        Subject='Previous Key has been deleted'
)

def lambda_handler(event, context):
    OldAccessKey = ListKey(UserName)
    DeleteKey = DeleteKey(OldAccessKey,UserName)
    CreateKey = CreateKey(UserName)
    AccessKey = CreateKey[0]
    SecretAccessKey = CreateKey[1]
    sns = SnsPublish(AccessKey, SecretAccessKey,UserName)