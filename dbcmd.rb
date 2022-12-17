#!/usr/bin/env ruby

require 'yaml'

command = ARGV.empty? ? 'mysql' : ARGV[0]
raise "Invalid command: #{command}" unless ['mysql', 'mysqldump'].include?(command)

CurrentDirectory = '.'
DatabaseYaml = 'config/database.yml'
BackupBase = File.join('db', 'backup')

PathToDatabaseYml = File.join(CurrentDirectory, DatabaseYaml)
datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

db_config = YAML::load(File.open(PathToDatabaseYml))

# puts "Production config: #{db_config['production'].inspect}"
p_config = db_config['production']

mysql_cmd = command
mysql_cmd += " -u #{p_config['username']}"
mysql_cmd += " '-p#{p_config['password']}'"
if p_config['host']
  mysql_cmd += " -h #{p_config['host']}"
else
  mysql_cmd += " --socket=#{p_config['socket']}"
end

mysql_cmd += " --ssl-ca=#{p_config['sslca']}"
mysql_cmd += " --ssl-key=#{p_config['sslkey']}"
mysql_cmd += " --ssl-cert=#{p_config['sslcert']}"
mysql_cmd += " #{p_config['database']}"

system mysql_cmd
