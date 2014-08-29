require 'spec_helper'

describe 'g5-nodejs::default' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'includes the nodejs default recipe' do
    expect(chef_run).to include_recipe('nodejs::default')
  end

  it 'configures the npm prefix' do
    expect(chef_run).to run_execute('npm config set prefix /home/vagrant/.node --global')
  end

  it 'installs the ember-cli node package' do
    expect(chef_run).to install_nodejs_npm('ember-cli')
  end

  it 'installs the bower node package' do
    expect(chef_run).to install_nodejs_npm('bower')
  end

  it 'makes the prefix directory writable by the group' do
    expect(chef_run).to run_execute('chmod -R 2775 /home/vagrant/.node')
  end

  it 'assigns the prefix directory to the vagrant group' do
    expect(chef_run).to run_execute('chown -R nobody:vagrant /home/vagrant/.node')
  end

  it 'creates the /etc/profile.d/npm.sh template' do
    expect(chef_run).to create_template('/etc/profile.d/npm.sh')
  end

  it 'clears the npm cache' do
    expect(chef_run).to run_execute('npm cache clean')
  end
end
