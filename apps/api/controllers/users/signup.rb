require 'bcrypt'

module Api::Controllers::Users
  class Signup
    include Api::Action
    accept :json

    params do
      required(:username).filled(:str?, min_size?: 3)
      required(:email).filled(:str?, format?: /@/)
      required(:password).filled(:str?, size?: 8..32)
    end

    def call(params)
      if params.valid?
        user = UserRepository.new.create(
          username: params[:username],
          email: params[:email],
          password_digest: BCrypt::Password.create(params[:password])
        )
        self.status = 201
        self.body = JSON.generate user
      else
        self.status = 422
        self.body = JSON.generate({ errors: params.errors, status: 422 })
      end
    end
  end
end
