import os
import platform

isDocker = input("\n Do you have docker installed on your machine?  y/n \n")

while (isDocker != 'n' and isDocker != 'y'):
    print(" Please either enter n or y. \n")
    isDocker = input(" Do you have docker installed on your machine?  y/n \n")


def run():
    container_name = input("\n Enter new container name: ")
    mysql_root_pass = input("\n Insert new root password for mysql: ")

    cmd1 = "docker run --name " + container_name + " --expose=3306 -e MYSQL_ROOT_PASSWORD=" + mysql_root_pass + " -d mysql/mysql-server:latest"

    run_cmd1 = os.system(cmd1)

    print("\n Your docker mysql container is created!\n\n - Run \"mysql --user=\'root\' --password=\'my-root-pass-mysql\'\" and then paste your SQL dump file.\n - After the first step, run \"exit\" twice to return to your directory.\n")

    # Access container bash terminal
    cmd2 = "docker exec -it " + container_name + " /bin/bash"
    run_cmd2 = os.system(cmd2)

    # # Access mysql from container bash terminal
    # cmd3 = "mysql --user=\"root\" --password=" + mysql_root_pass
    # run_cmd3 = os.system(cmd3)


if isDocker == 'y':
    run()


elif isDocker == 'n':
    osType = platform.system()

    if osType == 'Windows':
        print("Please install docker from the docker hub: https://hub.docker.com/editions/community/docker-ce-desktop-windows/")

    elif osType == 'Darwin':
        cmd3 = "brew install docker"
        run_cmd3 = os.system(cmd3)
        run()

    elif osType == 'Linux':

        #### Instaling through repo. Maybe useful for the future. ####
        #     cmd8 = "sudo apt-get update"
        #     cmd9 = "sudo apt-get install \
        # apt-transport-https \
        # ca-certificates \
        # curl \
        # gnupg-agent \
        # software-properties-common"
        #     cmd10 = "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
        #     fingerprint = input("Please insert the last 8 character of the fingerprint with no spaces:")
        #     cmd11 = "sudo apt-key fingerprint " + fingerprint

        cmd4 = "sudo apt-get remove docker docker-engine docker.io containerd runc"
        cmd5 = "sudo apt-get update"
        cmd6 = "sudo apt-get install docker-ce docker-ce-cli containerd.io"

        run_cmd4 = os.system(cmd4)
        run_cmd5 = os.system(cmd5)
        run_cmd6 = os.system(cmd6)
        run()

    print("\n Please enter either y or n")
