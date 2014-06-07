class Chef
  class Provider
    class MysqlChefGem < Chef::Provider::LWRPBase
      include Chef::Mixin::ShellOut
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      def action_install
        # Added gem_installed? check because the two resource below would
        # always converge, even if no changes were necessary
        unless gem_installed?
          converge_by 'install mysql chef_gem and dependencies' do
            recipe_eval do
              run_context.include_recipe 'build-essential::default'
            end
  
            recipe_eval do
              run_context.include_recipe 'mysql::client'
            end
  
            chef_gem 'mysql' do
              action :install
              source '/vagrant/mysql-2.9.1.gem'
            end
          end
        else
          Chef::Log.info('nothing to do - mysql gem already installed')
        end
      end

      def action_remove
        chef_gem 'mysql' do
          action :remove
        end
      end

      private

      def gem_installed?
      # Checks if the mysql gem is installed the embedded chef ruby
        cmd = '/opt/chef/embedded/bin/gem list | grep -c mysql'
        system(cmd)
      end
    end
  end
end
