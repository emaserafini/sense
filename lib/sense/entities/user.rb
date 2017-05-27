class User < Hanami::Entity
  def updated_at_iso8601
    updated_at.iso8601
  end
end
