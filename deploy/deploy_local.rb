

TOMCATE_PATH='/usr/local/apache-tomcat-7.0.40'
APP_PATH="#{TOMCATE_PATH}/webapps"
SCRIPT_START="#{TOMCATE_PATH}/bin/startup.sh"
SCRIPT_SHUTDOWN="#{TOMCATE_PATH}/bin/shutdown.sh"
MICROBLOG_APP_PATH="#{APP_PATH}/microblog"
PORJECT_PATH="/home/wisedulab2/wisedu_projects/Project/microblog-cache"
WAR_PATH="#{PORJECT_PATH}/target/microblog.war"


puts 'building...'

system "cd /home/wisedulab2/wisedu_projects/Project/microblog-cache \n mvn install"


puts "deploying"


if(File.exists?("#{MICROBLOG_APP_PATH}"))
	system "rm -R #{MICROBLOG_APP_PATH}"
end

system "cp -f #{WAR_PATH}  #{APP_PATH}/microblog.war"
puts "restart tomact"
system SCRIPT_SHUTDOWN
system SCRIPT_START
