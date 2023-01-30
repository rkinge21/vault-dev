import argparse
from lib.vault_api import vault_api_main
from lib.common import set_environment_params
from lib.common import get_platform

def main():
    print("\n----------     Inside Main    ----------")
    currentPlatform = get_platform()
    print("\nCurrent Platform : "+ currentPlatform)
    set_environment_params()
    vault_api_main(currentPlatform)
    # print("\nSelected Vault Tool : "+args.tool)
    # if args.tool=="api":
    #     vault_api_main(currentPlatform)
    # elif args.tool=="cli":
    #     print("Selected Vault Tool is cli")
    # else:
    #     print("Selected Vault Tool is neither api nor api.\nExitting....")
    #     exit(0)
    

if __name__ == "__main__":
    main()
    # parser = argparse.ArgumentParser(description='Generate Certificate via Vault')
    # parser.add_argument('-t', '--tool', required=True,  type=str ,
    #                     metavar="\n\n\tPlease pass vault tool as either --tool=cli  or --tool=api",
    #                     help='Pass vault tool as either --tool=cli  or --tool=api')
    # args = parser.parse_args()
    # main(args)