#Install Apache
package 'httpd' do
  action :install
  only_if { node['platform'] == 'redhat' }
end

package 'apache2' do
  action :install
  only_if { node['platform'] == 'ubuntu' }
end

###########################################################

# Configure Apache

directory '/var/www/html/LearnWithProjects-com' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
end

template '/etc/httpd/conf.d/proxyPass.conf' do
  source 'proxyPass.conf.erb'
end

template '/var/www/html/LearnWithProjects-com/index.html' do
	source 'index.html.erb'
end

template '/var/www/html/LearnWithProjects-com/lb-healthcheck.html' do
        source 'lb-healthcheck.html.erb'
end

######################################################################

# Start Apache

case node['platform']
when 'redhat'
  # Red Hat settings (ntpd)
  service_name = 'httpd'
  service_action = [:start, :enable, :reload]

when 'ubuntu'
  # ubuntu settings
  service_name = 'apache2'
  service_action = [:start, :enable, :reload]
end

#service 'httpd' do
#  action [:enable, :start, :reload]
#end

service 'httpd' do
  action [:enable, :start, :reload]
  only_if { node['platform'] == 'redhat' }
end

service 'apache2' do
  action [:enable, :start, :reload]
  only_if { node['platform'] == 'ubuntu' }
end

