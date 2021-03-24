import os
import platform

option = input("\n What do you want to do? \n 1 - Set up Jenkins. \n 2 - Back-up my jenkins. ")

while (option != '1' and option != 'y'):
    print("\n WARNING: Please insert either 1 or 2. ")
    option = input("\n What do you want to do? \n 1 - Set up Jenkins. \n 2 - Back up my jenkins. ")

if option == '1':

    portAv = input("\n Is port 8080 currently running any processes? (y/n): ")
    while (portAv != 'y' and portAv != 'n'):
        print("\n WARNING: Please insert either y or n. ")
        portAv = input("\n Is port 8080 currently running any processes? (y/n): ")

    if portAv == 'n':
        os.system("docker login")
        os.system("docker pull jenkins")
        os.system("docker images")
        contName = input(" Please insert the name of your new jenkins container: ")
        dataPath = input(" Please insert a pathfile for you jenkins data (e.g home/jenkins):  ")
        os.system("docker run --name " + contName + " -p 8080:8080 -p 50000:50000 --env JAVA_OPTS=\"-Djava.util.logging.config.file=/var/jenkins_home/log.properties\" -v " + dataPath + ":/var/jenkins_home jenkins")
    else:
        print("Please make sure there are no processes currently running on port 8080.")
else:
    os.system("docker cp $ID:/var/jenkins_home")

    ### SOME EXTRA GOODIES ###

    # docker run - -name myjenkins - p 8080: 8080 - p 50000: 50000 - -env JAVA_OPTS = -Dhudson.footerURL = http: // mycompany.com jenkins
    # docker run - -name myjenkins - p 8080: 8080 - p 50000: 50000 - v / var / jenkins_home jenkins
    # mkdir data
    # cat > data / log.properties << EOF
    # handlers = java.util.logging.ConsoleHandler
    # jenkins.level = FINEST
    # java.util.logging.ConsoleHandler.level = FINEST
    # EOF
    # docker run - -name myjenkins - p 8080: 8080 - p 50000: 50000 - -env JAVA_OPTS = "-Djava.util.logging.config.file=/var/jenkins_home/log.properties" - v `pwd` / data: / var / jenkins_home jenkins
