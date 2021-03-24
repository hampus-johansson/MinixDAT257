import os

os.system("sudo apt update")
os.system("sudo apt install nodejs")
os.system("sudo apt install npm")
os.system("sudo npm i -g pm2")

appName = input("\nSpecify the name of your app: ")
file_path = input("\nPlease enter the path to your startup file: ")
os.system("pm2 start " + file_path + " --name " + appName)
os.system("pm2 status")
