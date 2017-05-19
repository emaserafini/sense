module Api::Controllers::Ping
  class Index
    include Api::Action
    accept :json

    def call(params)
      self.body = JSON.generate({message: 'pong', status: 200})
    end
  end
end
