bash 'copy-war-file' do
  user 'root'
  cwd '/var/lib/tomcat8/webapps/'
  code <<-EOH
    rm -rf LoginRegisterApp LoginRegisterApp.war
    sleep 2
    curl -O https://artifactory-11am-weekdays.s3.ap-south-1.amazonaws.com/LoginRegisterApp.war
  EOH
end

