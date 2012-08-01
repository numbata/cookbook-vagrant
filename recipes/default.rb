vagrant_lucid_image = "vagrant_lucid.box"

directory "#{node['vagrant_boxes']['path']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/#{vagrant_lucid_image}" do
  source "#{node['vagrant_boxes']['image_url']}"
  mode 06444
  action :create_if_missing
end

node['vagrant_boxes']['boxes'].each do |box|
  vagrant_boxes_box "#{box['name']}" do
    action :install
    provider "vagrant_boxes_box"
  end
end

template "#{node['vagrant_boxes']['path']}/Vagrantfile" do
  source "Vagrantfile.erb"
  variables ({
    :boxes => node['vagrant_boxes']['boxes']
  })
end

execute "vagrant_reload" do
  user "root"
  cwd node['vagrant_boxes']['path']
  command "vagrant reload"
  only_if "vagrant status | grep -q running"
end

execute "vagrant_up" do
  user "root"
  cwd node['vagrant_boxes']['path']
  command "vagrant up"
  not_if "vagrant status | grep -q running"
end
