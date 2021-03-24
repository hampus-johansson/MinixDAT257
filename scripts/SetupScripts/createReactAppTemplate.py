import os
import platform


def nextScript():
    nextScript = "python react-native.py"
    run_nextScript = os.system(nextScript)


systemPlatform = platform.system()

if systemPlatform == "Linux":

    # Confirm if we should partake in this section of the instalation
    print("Would you like to setup a React application template? (Y/n): ")
    confirmation = raw_input()
    if (confirmation == "n") or (confirmation == "N"):
        exit("Skipping")

    # Confirm that we are running as root
    if os.geteuid() != 0:
        exit("You need to have root privileges to run this script.\nPlease try again, this time using 'sudo'. Exiting.")

    # Get the name of the application and convert to lower case (React does not allow upper case characters)
    print("What is the name of the application template?: ")
    applicationName = raw_input().lower()

    # Install necessary components, create folder template and run new server
    os.system("apt update")
    os.system("apt install -y nodejs npm")
    os.system("npm install -g serve")
    os.system("npx create-react-app " + applicationName)
    # TODO: run server
    #+" && cd " + applicationName + " && npm start")

elif systemPlatform == "Windows":
    print("Windows is not yet supported")
    nextScript()

elif systemPlatform == "Darwin":
    print("OSX is not yet supported")
    nextScript()

print("Thank you, your " + applicationName + " application template is now prepared!")

nextScript = "python3 react-native.py"
run_nextScript = os.system(nextScript)
