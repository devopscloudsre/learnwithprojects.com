for i in $(cat hosts);
do
v_host=$(echo $i|awk -F":" '{print $1}')
v_name=$(echo $i|awk -F":" '{print $2}')
echo "knife command as below "
knife bootstrap $v_host --connection-user root --ssh-identity-file /root/.ssh/id_rsa --node-name $v_name -y
done
