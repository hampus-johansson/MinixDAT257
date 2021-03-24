import os
import platform

def nextScript():
    nextScript = "python3 createReactAppTemplate.py"
    run_nextScript = os.system(nextScript)


install_express = input("Would like to build an express server? yes/no ")

if (install_express == "no"):
  nextScript()
else:
  os_type = platform.system()
  print(os_type)

  # install node
  npm_installed = input("Do you have npm installed on your computer? yes/no ")
  if (npm_installed == "no"):
    if (os_type == "Linux" or os_type == "Darwin"):
      cmd0 = "sudo apt-get install node"
    elif (os_type == "Darwin"):
      cmd0 = "brew install node"
    elif (os_type == "Windows"):
      print("Download node.js via : https://nodejs.org/en/download/")
    run_cmd0 = os.sytem(cmd0)

  #install the application generator as a global npm package
  cmd1 = "sudo npm install -g express-generator"
  print(cmd1)
  run_cmd1 = os.system(cmd1)

  #launch the application generator
  #os.system("express")
  #trial2 = os.system("express -h")

  app_name = input("What is the name of your app?")

  cmd2 = "express --view=pug " + app_name
  print(cmd2)
  run_cmd2 = os.system(cmd2)

  run_cmd3 = os.chdir(app_name)
  # varify the path using getcwd()
  cwd = os.getcwd()
  # print the current directory
  print("Current working directory is:", cwd)

  cmd = "cat appTemplate.js >> " + app_name
  print(cmd)
  os.system(cmd)

  cmd4 = "npm install"
  print(cmd4)
  run_cmd4 = os.system(cmd4)

  if (os_type == "Linux" or os_type == "Darwin"):
    cmd5 = "DEBUG=" + app_name + ":* npm start"
  elif (os_type == "Windows"):
    cmd5 = "SET DEBUG=" + app_name + ":* & npm start"

  print(cmd5)
  run_cmd5 = os.system(cmd5)
  nextScript()
