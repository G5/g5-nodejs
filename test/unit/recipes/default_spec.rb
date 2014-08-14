require 'spec_helper'

describe 'g5-nodejs::default' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'should include itself' do
    expect(chef_run).to include_recipe('g5-nodejs::default')
  end
end
