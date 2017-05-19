require 'spec_helper'

describe 'Visit ping' do
  include Rack::Test::Methods

  it 'returns 200 status and "pong" message' do
    get '/api/ping'

    expect(last_response.status).to eq 200
    expect(json_body).to eq({ message: 'pong', status: 200 })
  end
end
