--MYSQL Dump--

take dump : 
mysqldump -u <username> -p <database_name> > <backup_file_name>.sql

Replace <username> with your MySQL username.
Replace <database_name> with the name of the database you want to back up.
Replace <backup_file_name>1 with the desired name for the backup file (e.g., my_database_backup.sql). 

restore : 

mysql -u <username> -p <database> < backup.sql

* similar database have to be created before restoring.

--Send FILE to Remote Server ---

using SCP :
scp <local_file_path> <remote_username>@<remote_host>:<remote_file_path>

using SFTP (Secure File Transfer Protocol) :

Start an sftp session:
sftp <remote_username>@<remote_host>

Use put command to upload:
put <local_file_path> <remote_file_path>

Use get to do REVERSE:

RSYNC also do same.

---

curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer YOUR API TOKEN" "https://api.digitalocean.com/v2/account/keys"  -- getting ssh id from digital Ocean

----
--- MANUALY ADDING TLS CERTIFICATE in CLUSTER ---- 

-Create using openssl:

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt \
  -subj "/CN=DOMAIN_NAME"
  
-Add certificate in cluster as secret (this secret has to be defined in ingress configs)

kubectl create secret tls DOMAIN_NAME-tls \
  --cert=tls.crt \
  --key=tls.key \
  -n default
  
-----



