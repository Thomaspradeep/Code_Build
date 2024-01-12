import json
import boto3
uname = 'datauser3'
iam = boto3.client("iam")
sns = boto3.client('sns', region_name='us-east-1')

#Listing the exist keys
def ListKey(uname):
    ListKey = iam.list_access_keys(
        UserName = uname
    )
    OldAccessKey = ListKey['AccessKeyMetadata'][0]['AccessKeyId']
    print('\n')
    return OldAccessKey

#delete existing Access key 

def DeleteKey(OldAccessKey,uname):
    DeleteKey = iam.delete_access_key(
        AccessKeyId = OldAccessKey,
        UserName = uname
    )

#Create the New AccessKey and SecretKey

def CreateKey(uname):
    CreateKey = iam.create_access_key(
        UserName=uname
    )
    NewAccessKey = CreateKey['AccessKey']['AccessKeyId']
    NewSecretAccessKey = CreateKey['AccessKey']['SecretAccessKey']
    return NewAccessKey, NewSecretAccessKey

# Send SNS notification to user

def SnsPublish(AccessKey,SecretKey,uname):
    TargetArn = 'arn:aws:sns:us-east-1:941598205732:sns101'
    response1 = sns.publish(
        TargetArn = TargetArn,
        Message = "Hi {}, This is your new Access key {} and SecretKey {}".format(uname,AccessKey,SecretKey),
        Subject='Previous Key has been deleted'
)

def lambda_handler(event, context):
    OldAccessKey = ListKey(uname)
    DeleteKey = DeleteKey(OldAccessKey,uname)
    CreateKey = CreateKey(uname)
    AccessKey = CreateKey[0]
    SecretAccessKey = CreateKey[1]
    sns = SnsPublish(AccessKey, SecretAccessKey,uname)