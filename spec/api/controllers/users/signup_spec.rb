require_relative '../../../../apps/api/controllers/users/signup'

RSpec.describe Api::Controllers::Users::Signup do
  let(:action) { described_class.new }
  let(:repository) { UserRepository.new }

  before { repository.clear }

  describe 'with valid params' do
    let(:params) { { email: 'foo@example.com', username: 'foo', password: 'my_secret' } }

    it 'is signup a user' do
      action.call(params)
      subject = repository.last

      expect(subject).not_to be_nil
      expect(subject.email).to eq params[:email]
      expect(subject.username).to eq params[:username]
    end

    it 'returns HTTP created status' do
      response = action.call(params)
      expect(response[0]).to eq 201
    end
  end

  describe 'with invalid params' do
    let(:params) { { email: 'invalid email', username: 's', password: '' } }

    it 'returns HTTP client error' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'dumps errors from command errors' do
      response = action.call(params)
      command_errors = action.command.validation.errors

      body = JSON.parse response[2].first, symbolize_names: true
      expect(command_errors).to eq body[:errors]
    end
  end
end
