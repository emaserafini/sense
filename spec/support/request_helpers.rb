module RequestHelpers
  def app
    Hanami.app
  end

  def json_body
    JSON.parse last_response.body, symbolize_names: true
  end
end
