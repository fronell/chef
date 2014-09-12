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
knife cookbook upload database
knife cookbook upload mysql-wrapper
knife cookbook upload sharing
knife cookbook upload utility_vm-runlist

# Databags
#knife data bag create users
#knife data bag from file users data_bags/users/user1.json
