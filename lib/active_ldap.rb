require_gem_if_need = Proc.new do |library_name, gem_name, *gem_args|
  gem_name ||= library_name
  begin
    if !gem_args.empty? and Object.const_defined?(:Gem)
      gem gem_name, *gem_args
    end
    require library_name
  rescue LoadError
    require 'rubygems'
    gem gem_name, *gem_args
    require library_name
  end
end

require_gem_if_need.call("active_support", "activesupport", ">= 3.0.0")

if ActiveSupport
  require 'active_support/dependencies'
  require 'active_support/all'
end

if ActiveSupport.const_defined?(:Dependencies)
  dependencies = ActiveSupport::Dependencies
else
  dependencies = Dependencies
end

if dependencies.respond_to?(:load_paths)
  dependencies.load_paths << File.expand_path(File.dirname(__FILE__))
end

module ActiveLdap
  VERSION = "1.2.3"
end

if RUBY_PLATFORM.match('linux')
  require 'active_ldap/timeout'
else
  require 'active_ldap/timeout_stub'
end

require_gem_if_need.call("active_record", "activerecord", ">= 3.0.0")
begin
  require_gem_if_need.call("locale", nil, "= 2.0.5")
  require_gem_if_need.call("fast_gettext", nil, "= 0.5.8")
rescue LoadError
end
require 'active_ldap/get_text'

require 'active_ldap/compatible'

require 'active_ldap/base'

require 'active_ldap/distinguished_name'
require 'active_ldap/ldif'
require 'active_ldap/xml'

require 'active_ldap/associations'
require 'active_ldap/attributes'
require 'active_ldap/configuration'
require 'active_ldap/connection'
require 'active_ldap/operations'
require 'active_ldap/object_class'
require 'active_ldap/human_readable'

require 'active_ldap/acts/tree'

require 'active_ldap/populate'
require 'active_ldap/escape'
require 'active_ldap/user_password'
require 'active_ldap/helper'

require 'active_ldap/validations'
require 'active_ldap/callbacks'

require 'active_ldap/command'


ActiveLdap::Base.class_eval do
  include ActiveLdap::Associations
  include ActiveLdap::Attributes
  include ActiveLdap::Configuration
  include ActiveLdap::Connection
  include ActiveLdap::Operations
  include ActiveLdap::ObjectClass
  include ActiveLdap::HumanReadable

  include ActiveLdap::Acts::Tree

  include ActiveLdap::Validations
  include ActiveLdap::Callbacks
end

unless defined?(ACTIVE_LDAP_CONNECTION_ADAPTERS)
  ACTIVE_LDAP_CONNECTION_ADAPTERS = %w(ldap net_ldap jndi)
end

ACTIVE_LDAP_CONNECTION_ADAPTERS.each do |adapter|
  require "active_ldap/adapter/#{adapter}"
end


if defined?(Rails)
  require 'active_ldap/railtie'
end
