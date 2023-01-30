import requests, json
import os
from lib.common import create_cert_path
from lib.common import save_to_file
from pprint import pprint

def vault_api_main(currentPlatform):
    print("\n----------     Inside Vault API Main Function   ----------\n")
    vault_api_health_check()
    vault_api_generate_certs(currentPlatform)

def vault_api_generate_certs(currentPlatform):
    print("\n----------     Inside Vault Generate Certificate Function   ----------\n")
    url = os.getenv('VAULT_ADDR')+"/v1/"+os.getenv('CA_NAME')+"/issue/"+os.getenv('ROLE_NAME')
    headers = {
            'X-Vault-Token': os.getenv("VAULT_TOKEN")
        }
    with open("payload.json") as json_file:
        vault_payload = json.load(json_file)

    response = requests.post(url, data=json.dumps(vault_payload), headers=headers)
    # pprint(response.json())

    if (response.status_code == 200):
        print("The request was a success!")
        response_data = response.json()
        # print("\nIssuing CA :\n" + str(response_data["data"]["issuing_ca"]))
        # print("\nCertificate :\n" + str(response_data["data"]["certificate"]))
        # print("\nPrivate Key :\n" + str(response_data["data"]["private_key"]))
        # print("\nCA Chain :\n" + str(response_data["data"]["ca_chain"][0]))
        
        cert_path=create_cert_path(currentPlatform)
        pretty_data = json.dumps(response.json(), indent=2)

        save_to_file(cert_path+"/vault_response.json", "w", pretty_data)
        save_to_file(cert_path+"/issuing_ca.crt", "w", response_data["data"]["issuing_ca"])
        save_to_file(cert_path+"/avengers.mcu.com.crt", "w", response_data["data"]["certificate"])
        save_to_file(cert_path+"/avengers.mcu.com.key", "w", response_data["data"]["private_key"])
        # save_to_file(cert_path+"ca_chain.pem", "w", response_data["data"]["ca_chain"][0])
        create_ca_chain_file(currentPlatform, cert_path)
        print("\n-------    Certificates generated Successfully at location : "+cert_path+"   -------\n")

    elif (response.status_code != 200):
        print("Result not found!")
        pprint(response.json())
        exit(0)

def create_ca_chain_file(currentPlatform, cert_path): 
    if (currentPlatform == "Windows"):
        os.system("echo & echo. > "+cert_path+"temp.txt") 
        os.system("echo & echo. >> "+cert_path+"temp.txt") 
        # os.system("copy certs\avengers.mcu.com.crt + certs\issuing_ca.crt  certs\ca_chain.pem") 
        # os.system("type certs\avengers.mcu.com.crt certs\issuing_ca.crt > certs\ca_chain.pem") 
        os.system("type "+cert_path+"avengers.mcu.com.crt "+cert_path+"temp.txt "+cert_path+"issuing_ca.crt >> "+cert_path+"ca_chain.pem") 
        os.system("del "+cert_path+"temp.txt") 


    elif (currentPlatform == "Linux"):
        # os.system("cat certs/avengers.mcu.com.crt <(echo) <(echo) certs/issuing_ca.crt > certs/ca_chain.pem") 
        os.system("echo -e '\n\n' >> "+cert_path+"avengers.mcu.com.crt")  
        os.system("cat "+cert_path+"avengers.mcu.com.crt "+cert_path+"issuing_ca.crt > "+cert_path+"ca_chain.pem") 


def vault_api_health_check():
    headers = {'X-Vault-Token': os.getenv("VAULT_TOKEN")}
    response = requests.get(os.getenv('VAULT_ADDR')+"/v1/sys/health", headers=headers)
    if (response.status_code == 200):
        print("!!------------  Health Check Successful.  ------------!!\n")
    elif (response.status_code != 200):
        print("!!------------  Health Check Result not found  ------------!!")
        print(response)
        pprint(response.json())
        exit(0)
