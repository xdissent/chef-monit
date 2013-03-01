#
# Cookbook Name:: monit
# Provider:: rc
#

include Chef::Mixin::LanguageIncludeRecipe

action :enable do
  include_recipe "monit"
  run_template_action :create
end

action :disable do
  include_recipe "monit"
  run_template_action :delete
end

private
def template_path
  "#{node["monit"]["conf_d"]}/#{new_resource.name}.conf"
end

def template_variables
  {name: new_resource.name}.merge(new_resource.variables || {})
end

def run_template_action(name)
  r = template_resource
  r.run_action name
  new_resource.updated_by_last_action r.updated_by_last_action?
end

def template_resource
  vars = template_variables
  template template_path do
    owner "root"
    group "root"
    mode "0644"
    source new_resource.template
    cookbook new_resource.cookbook
    variables vars
    action :nothing
  end
end