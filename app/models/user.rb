class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :nickname
  validates_presence_of :password_digest

  before_create :generate_registration_key
  before_validation :standardize_email

  private
  def generate_registration_key
    generate_token(:registration_key)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def standardize_email
    email.downcase! if email
  end
end
