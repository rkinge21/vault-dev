import os
import platform
import configparser

def set_environment_params():
    try:
        print("\n---   Set VAULT_ADDR, VAULT_TOKEN as Environments Params   ---\n")
        config = configparser.ConfigParser()
        config.read('config.properties')

        os.environ["VAULT_ADDR"] = config['vault']['VAULT_ADDR']
        os.environ["VAULT_TOKEN"] = config['vault']['VAULT_TOKEN']

        print(f'VAULT_ADDR      : ' + os.getenv('VAULT_ADDR'))
        print(f'VAULT_TOKEN     : ' + os.environ.get('VAULT_TOKEN'))
        
        os.environ["ROLE_NAME"] = config['vault_cli']['ROLE_NAME']
        os.environ["CA_NAME"] = config['vault_cli']['CA_NAME']

        os.environ["CERT_LOCATION"] = config['certs']['CERT_LOCATION']
        
        # for section_name in config.sections():
        #     print('\nSection:', section_name)
        #     print('  Options:', config.options(section_name))
        #     for key, value in config.items(section_name):
        #         print('  {} = {}'.format(key, value))
    except (IOError, EOFError) as ex:
        print("Testing multiple exceptions. {}".format(ex.args[-1]))
    except Exception as err:
        print("Something went wrong when reading config.ini file")
        print("Error:", err)
        exit(0)
    finally:
        config.clear()


def create_cert_path(currentPlatform): 
    if (currentPlatform == "Windows"):
        cert_path=os.getcwd()+"\\"+os.getenv('CERT_LOCATION')+"\\"
        os.system("rmdir /s /q "+cert_path)
        os.system("mkdir "+cert_path)
        return cert_path
    elif (currentPlatform == "Linux"):
        cert_path=os.getcwd()+"/"+os.getenv('CERT_LOCATION')+"/"
        os.system("rm -rf "+cert_path)
        os.system("mkdir -p "+cert_path)
        return cert_path



def save_to_file(filename, mode, content):
    file = open(filename, mode)
    file.write(str(content))
    file.close()


def get_platform():
    # print("System       : " + platform.system())  # e.g. Windows, Linux, Darwin
    # print("Architecture : " + str(platform.architecture()))  # e.g. 64-bit
    # print("Machine      : " + platform.machine())  # e.g. x86_64
    # print("Node         : " + platform.node())  # Hostname
    # print("Processor    : " + platform.processor())  # e.g. i386
    return platform.system()
    
def print_directory_path():
    print("\n----------     Inside print_directory_path    ----------")
    print("\nThis file full path (following symlinks)")
    full_path = os.path.realpath(__file__)
    print(full_path)

    print("\nThis file directory only")
    print(os.path.dirname(full_path))
    
    print("\nPath at terminal when executing this file")
    print(os.getcwd())

    print("\nThis file path, relative to os.getcwd()")
    print(__file__)