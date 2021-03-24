import os
import platform
import getpass
import socket

# Start securing a wp site through replacement of all http:// to https://
# We also enable switching of wp domain eg site1.ctk.se to site2.ctk.se.

# Prompt for current host name
# Usually defined in nginx config.
#newHostCond = input(" Would you like to update database to new hostname? y/n: ")
print(socket.gethostname())
newHost = input(" Enter new hostname: ")
# Prompt for db ascociated with said wp hostname
# Find in $app_root/wp-config.php
dbName = input(" Enter db name for current host: ")
# Prompt for mysql root password
msqlpw = getpass.getpass(" Enter mysql root password: ")

# Determine what the old URL was and save it to a variable

oldURL = "mysql -u root -p " + msqlpw + " " + dbName + " -e \'select option_value from " + dbName + " options where option_id = 1;\' | grep http"

# #SQL statements to update database to new hostname
sqlcmd = "UPDATE " + dbName + " options SET option_value = replace(option_value, \'" + oldURL + "\', \'http://" + newHost + "\') WHERE option_name = 'home' OR option_name = 'siteurl';"

sqlcmd1 = "UPDATE " + dbName + " posts SET guid = replace(guid, \'" + oldURL + "\', \'http://" + newHost + "\');"

sqlcmd2 = "UPDATE " + dbName + " posts SET post_conect = replace(postcontent, \'" + oldURL + "\', \'http://" + newHost + "\');"

sqlcmd3 = "UPDATE " + dbName + " postsmeta SET meta_value = replace(meta_value, \'" + oldURL + "\', \'http://" + newHost + "\');"

# Run sql statements
sqlCommand = "mysql -u root -p " + msqlpw + " " + dbName + " -e " + sqlcmd
run_sqlCommand = os.system(sqlCommand)
sqlCommand1 = "mysql -u root -p " + msqlpw + " " + dbName + " -e " + sqlcmd1
run_sqlCommand = os.system(sqlCommand1)
sqlCommand2 = "mysql -u root -p " + msqlpw + " " + dbName + " -e " + sqlcmd2
run_sqlCommand = os.system(sqlCommand2)
sqlCommand3 = "mysql -u root -p " + msqlpw + " " + dbName + " -e " + sqlcmd3
run_sqlCommand = os.system(sqlCommand3)

