#!/bin/bash

# Cookbooks
knife cookbook upload cron
knife cookbook upload logrotate
knife cookbook upload chef-client
knife cookbook upload base
knife cookbook upload base-runlist
knife cookbook upload users
knife cookbook upload yum
knife cookbook upload linux_base
knife cookbook upload linux_base-runlist
knife cookbook upload build-essential
knife cookbook upload mysql-chef_gem
knife cookbook upload mysql
knife cookbook upload database
knife cookbook upload mysql-wrapper

# Databags
knife data bag create users
knife data bag from file users data_bags/users/user1.json
