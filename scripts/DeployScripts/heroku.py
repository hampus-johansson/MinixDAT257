# install node/npm via https://nodejs.org/en/download/
# install git via https://www.atlassian.com/git/tutorials/install-git, 
# install heroku CLI via https://devcenter.heroku.com/articles/heroku-cli#download-and-install

import os
import platform


os_type = platform.system()
print(os_type)

# This only work for Linux/Mac Os environment
if (os_type == "Windows"):
    exit

# move into your project directory
project_name = input("What is the name of your project directory? ")
cmd = "mkdir " + project_name
os.system(cmd)
os.chdir(project_name)

git_repo = input("What is the url of your github repository? ")
cmd = "git clone " + git_repo
os.system(cmd)

# you need to have a free Heroku account to do this
# adding the -i flag lets you login through the command line
cmd = "heroku login -i"
os.system(cmd)

#  you can create a new Heroku project
heroku_project = input("What is the name of your new Heroku project? ")
cmd = "heroku create " + heroku_project
os.system(cmd)

# initialise a new npm project by creating a package.json file
# Heroku relies on you providing a package.json file to know this
# is a Node.js project when it builds your app
cmd = "npm init -y"
os.system(cmd)
# install Express mettre lien de mon file https://expressjs.com/en/starter/installing.html 
cmd = "npm install express --save"
os.system(cmd)

app_name = input("What is the name of your express app?")

#save the app and start the server with :
launch = input("Do you want to lauch the app? y/n")
if (launch == "y"): 
   cmd = "node " + app_name
   os.system(cmd)
   print("Visit the localhost:3000 in your browser")

# in app.js you told the express.static middlteware to serve static files from the public directory
# so create such a directory and the files it will contain

cmd = "mkdir public"
os.system(cmd)
os.chdir("public")
cmd = "touch index.html styles.css script.js"
os.system(cmd)

# Edit index.html, styles.css, script.js

# Deploying your app -> ask if they want to
deploy = input("Do you want to deploy your app? y/n")
if (deploy == "y"):
    # Create a Procfile (Heroka need a Procfile to know how to run your app)
    cmd = "echo \"web: node " +app_name+ " \" > Procfile"
    os.system(cmd)
    cmd = "git add"
    os.system(cmd)
    cmd = "git commit -m \"ready to deploy\" "
    os.system(cmd)
    # push to your Heroku master branch
    cmd ="git push heroku master"
    os.system(cmd)