import os
 
port = input('Are you currently running any processes on port 8080? y/n: ')
 
while (port != 'y' and port != 'n'):
    port = input('Please either input \'y\' or \'n\': ')
    
if port == 'n':
    # Install java environment
    os.system('sudo apt-get install openjdk-8-jre')
    os.system('sudo apt-get install openjdk-8-jdk')
    print('Your java version is: ')
    os.system('java -version')
 
    os.system('wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -')
    os.system('sudo sh -c \'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list\'')
    os.system('sudo apt-get update')

    key = input('Input your key here: ')
    os.system('sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ' + key)
    os.system('sudo apt-get update')
    os.system('sudo apt-get install jenkins')

    print('Your password is: ')
    os.system('sudo cat /var/lib/jenkins/secrets/initialAdminPassword')
    os.system('sudo apt-get install git')

    print('Jenkins is now running on port 8080')
else:
    print('Please kill your process on port 8080')
    
