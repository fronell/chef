current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "client"
client_key               "#{current_dir}/knife.pem"
validation_client_name   "validator"
validation_key           "#{current_dir}/validator.pem"
chef_server_url          "http://192.168.1.79:8000"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks",
                          "#{current_dir}/../role_cookbooks",
                          "#{current_dir}/../vendor_cookbooks"]
