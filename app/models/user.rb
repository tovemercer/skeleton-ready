class User < ActiveRecord::Base
  validates :username, :email, presence: true, uniqueness: true

  include BCrypt

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && user.password == password
  end
end
