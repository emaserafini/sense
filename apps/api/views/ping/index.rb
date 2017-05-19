module Api::Views::Ping
  class Index
    include Api::View
    layout false

    def render
      raw JSON.generate({message: 'pong', status: 200})
    end
  end
end
