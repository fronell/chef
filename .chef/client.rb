# last seen recipes handler
require "last_seen_recipes"
last_seen_recipes_handler = LastSeenRecipesHandler.new
report_handlers << last_seen_recipes_handler

log_level              :info
log_location           STDOUT
ssl_verify_mode        :verify_none
chef_server_url        "http://192.168.1.79:8000"
validation_client_name "chef-validator"
validation_key         "/etc/chef/validation.pem"
client_key             "/etc/chef/client.pem"
