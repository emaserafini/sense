module Api::Controllers::Users
  class Signup
    include Api::Action
    accept :json

    expose :command

    def call(params)
      @command = SignupCommand.run(params)
      if @command.successful?
        self.status = 201
        self.body = JSON.generate @command.user.to_h
      else
        self.status = 422
        self.body = JSON.generate({ errors: @command.validation.errors, status: 422 })
      end
    end
  end
end
