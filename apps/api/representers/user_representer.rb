class UserRepresenter < ApiRepresenter
  property :id
  property :username
  property :email
  property :updated_at_iso8601, as: :updated_at
end
