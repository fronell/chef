include_recipe "base::chef_gems"
include_recipe "chef-client::config"
# Its convenient to leave the validation.pem on the system for testing
#include_recipe "chef-client::delete_validation"
