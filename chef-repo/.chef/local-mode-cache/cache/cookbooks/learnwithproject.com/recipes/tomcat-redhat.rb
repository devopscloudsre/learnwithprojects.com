bash 'tomcat-redhat-install' do
  user 'root'
  cwd '/etc'
  code <<-EOH
    rm -f apache-tomcat-8.5.61.tar.gz
    wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz
    tar xvfz apache-tomcat-8.5.61.tar.gz
    ln -s apache-tomcat-8.5.61 tomcat8
    cd /etc/tomcat8/webapps
    rm -rf LoginRegisterApp LoginRegisterApp.war
    sleep 2
    wget https://artifactory-11am-weekdays.s3.ap-south-1.amazonaws.com/LoginRegisterApp.war
    cd /etc/tomcat8/bin/
    sh startup.sh
    sudo -i setsebool -P httpd_can_network_connect on
    EOH
end

########Configure########################################

template '/etc/tomcat8/conf/tomcat-users.xml' do
	source 'tomcat-users.xml.erb'
end

template '/etc/tomcat8/webapps/manager/META-INF/context.xml' do
	source 'context.xml.erb'
end

bash 'tomcat-redhat-restart' do
  user 'root'
  cwd '/etc/tomcat8/bin'
  code <<-EOH
    sh shutdown.sh
    sleep 2
    sh startup.sh
    EOH
end
