##
# This class representing a MyCashFlow User. In this class you'll
# find the auth methods and user information. It uses some devise 
# default modules like :registerable, :database_authenticatable,
# :recoverable, :rememberable, :trackable, :validatable
class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable
##
# Class relatioship has_many :accounts, dependent: :destroy
  has_many :accounts, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }
  validates_uniqueness_of :auth_token

  before_create :generate_authentication_token!

##
# Bring some information about the user (Email and Created_at)
  def info
    "#{email} - #{created_at}"
  end

##
# Generate the token that controls the user session
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while User.exists?(auth_token: auth_token)
  end
end
