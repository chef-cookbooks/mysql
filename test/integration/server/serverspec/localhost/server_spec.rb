require 'spec_helper'

describe 'mysql server process' do
  it 'answers on port 3306' do
    expect(port 3306).to be_listening
  end
end
