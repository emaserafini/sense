require 'bcrypt'

class SignupCommand
  attr_reader :attributes, :validation, :user

  def self.run(attributes)
    new(attributes).tap{ |command| command.run }
  end

  def initialize(attributes)
    @attributes = attributes
    @validation = SignupValidator.new(attributes).validate
  end

  def run
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
