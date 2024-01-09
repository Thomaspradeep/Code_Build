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
    AccessKey = ListKey['AccessKeyMetadata'][0]['AccessKeyId']
    print('\n')
    return AccessKey

#delete existing Access key 

def DeleteKey(accesskey,uname):
    DeleteKey = iam.delete_access_key(
        AccessKeyId = accesskey,
        UserName = uname
    )
    print("*************************** \n")
    print(f'{accesskey} deleted for {uname} and new key will creating \n')
    print("*************************** \n")

#Create the New AccessKey and SecretKey

def CreateKey(uname):
    CreateKey = iam.create_access_key(
        UserName=uname
    )
    AccessKeyId = CreateKey['AccessKey']['AccessKeyId']
    SecretAccessKey = CreateKey['AccessKey']['SecretAccessKey']
    print("AccessKeyId: ", AccessKeyId, "\n SecretAccessKey: ", SecretAccessKey)
    print(f"AccessKey and SecretKey created for {uname} and shared the Key details with Transunion user mail ID ")
    print("\n *****************************")
    return AccessKeyId, SecretAccessKey

def SnsPublish(key, secret):
    TargetArn = 'arn:aws:sns:us-east-1:941598205732:sns101'
    response1 = sns.publish(
        TargetArn = TargetArn,
        Message = "This is your new Access key {} and SecretKey {}".format(key,secret),
        Subject='Previous Key has been deleted'
)

def lambda_handler(event, context):
    accesskey = ListKey(uname)
    status = ListKey(uname)
    delete = DeleteKey(accesskey,uname)
    create = CreateKey(uname)
    AccessKey = create[0]
    SecretAccessKey = create[1]
    sns = SnsPublish(AccessKey, SecretAccessKey)
    print(f'''Successfully new AccessKey and SecretKey created for Transunion User
    
          ******************************* ''' )
    print(AccessKey)
    print(SecretAccessKey)