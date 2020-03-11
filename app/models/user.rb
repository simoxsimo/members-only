class User < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true,
                       length: { minimum: 6 }
  has_secure_password
  has_many :posts
  before_create :token_encrypt
  attr_accessor :token

  def User.new_token
    SecureRandom.urlsafe_base64 
  end

  def token_encrypt
    token_string=User.new_token
    add_remember_token = Digest::SHA1.hexdigest(token_string)
    self.remember_token =add_remember_token
  end
end
