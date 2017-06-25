##
# This class representing a API User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #  :confirmable, :lockable
  has_many :accounts, dependent: :destroy
  validates :email, uniqueness: { case_sensitive: false }
  validates_uniqueness_of :auth_token

  before_create :generate_authentication_token!
##
# Bring some information about the user (Email and Created_at)
  def info
    "#{email} - #{created_at}"
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while User.exists?(auth_token: auth_token)
  end
end
