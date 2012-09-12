require 'chef/mixin/shell_out'
require 'chef/mixin/language'

include Chef::Mixin::ShellOut

action :install do
  Chef::Log.info("Installing #{new_resource.name}")

  Chef::Log.info("Vagrant copy image #{new_resource.name}")
  execute "vagrant_boxes_copy_#{new_resource.name}" do
    user "root"
    cwd node['vagrant_boxes']['path']
    command "cp -n #{Chef::Config[:file_cache_path]}/vagrant_lucid.box #{node['vagrant_boxes']['path']}/vagrant_#{new_resource.name}.box"
    creates "#{node['vagrant_boxes']['path']}/vagrant_#{new_resource.name}.box"
  end

  Chef::Log.info("Vagrant add #{new_resource.name}")
  execute "vagrant_boxes_add_#{new_resource.name}" do
    user "root"
    cwd node['vagrant_boxes']['path']
    command "vagrant box add #{new_resource.name} #{node['vagrant_boxes']['path']}/vagrant_#{new_resource.name}.box"
    not_if "vagrant box list | grep -qE '^#{new_resource.name}$'"
  end

  new_resource.updated_by_last_action(true)
end
