class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 },
                       if: :password_required?

  private

  def password_required?
    !password.blank? || password_digest.nil?
  end
end
