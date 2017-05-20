require_relative '../../../../apps/api/controllers/users/signup'

RSpec.describe Api::Controllers::Users::Signup do
  let(:action) { described_class.new }
  let(:repository) { UserRepository.new }

  before do
    repository.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[email: 'foo@example.com', username: 'foo', password: 'my_secret'] }

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
    let(:params) { Hash[email: 'invalid email', username: 's', password: ''] }

    it 'returns HTTP client error' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'dumps errors in params' do
      action.call(params)
      errors = action.params.errors

      expect(errors[:email]).to include 'is in invalid format'
      expect(errors[:username]).to include 'size cannot be less than 3'
      expect(errors[:password]).to include 'must be filled'
    end
  end
end
