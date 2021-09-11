class User < ApplicationRecord
  
  has_many :reviews, dependent: :destroy
  
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5, allow_blank: true }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-Z0-9]+\z/i }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end
