include_recipe 'nodejs::default'

execute 'Configure npm prefix' do
  command "npm config set prefix #{node['nodejs']['npm']['prefix']} --global"
end

template '/etc/profile.d/npm.sh' do
  source 'npm.sh.erb'
  mode 0640
  owner 'root'
  group 'vagrant'
  variables(
    prefix: node['nodejs']['npm']['prefix']
  )
end

%w{ember-cli bower grunt-cli}.each do |pkg|
  nodejs_npm pkg do
    group 'vagrant'
  end
end

execute 'Set prefix directory group permissions' do
  command "chmod -R 2775 #{node['nodejs']['npm']['prefix']}"
end

execute 'Set prefix directory ownership' do
  command "chown -R nobody:vagrant #{node['nodejs']['npm']['prefix']}"
end

execute 'Clear npm cache' do
  command 'npm cache clean'
end
