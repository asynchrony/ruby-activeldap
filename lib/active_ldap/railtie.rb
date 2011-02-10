module Rails
	module ActiveLdap
		class Railtie < Rails::Railtie
			initializer "setup database" do
				ldap_configuration_file = Rails.root.join("config", "ldap.yml")
				if ldap_configuration_file.file?
					configurations = YAML.load(ERB.new(IO.read(ldap_configuration_file)).result)
				  ::ActiveLdap::Base.configurations = configurations
				  ::ActiveLdap::Base.setup_connection
				  ::ActiveLdap::Base.logger ||= Rails.logger
				end
	        end
	
	      # After initialization we will warn the user if we can't find a mongoid.yml and
	      # alert to create one.
	      initializer "warn when configuration is missing" do
	        config.after_initialize do
	        	puts "|#{Rails.root}| - |#{Rails.root.join('config', 'ldap.yml')}|"
	          unless Rails.root.join("config", "ldap.yml").file?
				puts("You should run 'script/generator scaffold_active_ldap' to make ldap.yml.")
              end
	        end
	      end
		end
	end
end

class ::ActionView::Base
  include ActiveLdap::Helper
end

