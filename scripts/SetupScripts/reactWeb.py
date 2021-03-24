import os
import platform

name = input("\n What is the name of your application? \n")

cmd0 = "npm update"
run_cmd0 = os.system(cmd0)
cmd1 = "npx create-react-app " + name
run_cmd1 = os.system(cmd1)
cmd2 = "cd " + name
run_cmd2 = os.system(cmd2)
cmd3 = "npm start"
run_cmd3 = "npm start"
