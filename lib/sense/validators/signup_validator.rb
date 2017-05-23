class SignupValidator
  include Hanami::Validations::Form

  predicate :case_insensitive_unique?, message: 'must be unique' do |attr_name, value|
    !UserRepository.new.users.where(Sequel.function(:lower, attr_name) => value.downcase).exist?
  end

  validations do
    required(:username).filled(:str?, min_size?: 3, case_insensitive_unique?: :username)
    required(:email).filled(:str?, format?: /\A[^@\s]+@[^@\s]+\z/, case_insensitive_unique?: :email)
    required(:password).filled(:str?, size?: 8..32)
  end
end
