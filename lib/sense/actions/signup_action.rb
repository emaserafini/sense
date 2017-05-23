class SignupAction
  attr_reader :attributes, :validation, :user

  def self.execute(attributes)
    new(attributes).tap do |action|
      action.execute
    end
  end

  def initialize(attributes)
    @attributes = attributes
    @validation = SignupValidator.new(attributes).validate
  end

  def execute
    validation.success? && register_user
  end

  def successful?
    user
  end

  def register_user
    @user = UserRepository.new.create(
      username: attributes[:username],
      email: attributes[:email],
      password_digest: BCrypt::Password.create(attributes[:password])
    )
  end
end
