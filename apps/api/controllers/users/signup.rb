require 'bcrypt'

module Api::Controllers::Users
  class Signup
    include Api::Action
    accept :json

    def call(params)
      signup = SignupAction.execute(params)
      if signup.successful?
        self.status = 201
        self.body = JSON.generate signup.user.to_h
      else
        self.status = 422
        self.body = JSON.generate({ errors: signup.validation.errors, status: 422 })
      end
    end
  end
end
