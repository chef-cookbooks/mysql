require 'spec_helper'

describe 'mysql_test::mysql_service_attribues' do
  let(:smartos_13_4_0_supported_run) do
    ChefSpec::Runner.new(
      :platform => 'smartos',
      :version => '5.11' # Do this for now until Ohai can identify SmartMachines
      ) do |node|
      node.set['mysql']['service_name'] = 'smartos_13_4_0_supported'
      node.set['mysql']['version'] = '5.6'
      node.set['mysql']['port'] = '3308'
      node.set['mysql']['data_dir'] = '/data'
    end.converge('mysql_test::mysql_service_attributes')
  end

  context 'when using an supported version' do
    it 'creates raises an error' do
      expect(smartos_13_4_0_supported_run).to create_mysql_service('smartos_13_4_0_supported').with(
        :version => '5.6',
        :port => '3308',
        :package_name => 'mysql-server',
        :data_dir => '/data'
        )
    end
  end
end
