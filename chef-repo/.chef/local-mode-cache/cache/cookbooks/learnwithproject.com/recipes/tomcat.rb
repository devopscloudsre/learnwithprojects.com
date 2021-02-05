case node[:platform]
  when 'redhat', 'centos'
    package 'java-1.8*'
    include_recipe 'learnwithproject.com::tomcat-redhat'
  when 'ubuntu', 'debian'
    apt_package 'tomcat8'
    include_recipe 'learnwithproject.com::tomcat-ubuntu'
end

