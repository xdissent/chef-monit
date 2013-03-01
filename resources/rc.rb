#
# Cookbook Name:: monit
# Resource:: rc
#

actions :enable, :disable
default_action :enable
attribute :template, kind_of: [String, NilClass], default: "initd.conf.erb"
attribute :cookbook, kind_of: [String, NilClass], default: "monit"
attribute :variables, kind_of: [Hash, NilClass], default: nil