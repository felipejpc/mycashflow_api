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
  has_many :credit_cards, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }
  validates_presence_of :email, :full_name, :short_name
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

# == Schema Information
#
# Table name: users
#
# *id*::                     <tt>integer, not null, primary key</tt>
# *email*::                  <tt>string, default(""), not null</tt>
# *encrypted_password*::     <tt>string, default(""), not null</tt>
# *reset_password_token*::   <tt>string</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *sign_in_count*::          <tt>integer, default(0), not null</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>inet</tt>
# *last_sign_in_ip*::        <tt>inet</tt>
# *confirmation_token*::     <tt>string</tt>
# *confirmed_at*::           <tt>datetime</tt>
# *confirmation_sent_at*::   <tt>datetime</tt>
# *unconfirmed_email*::      <tt>string</tt>
# *failed_attempts*::        <tt>integer, default(0), not null</tt>
# *unlock_token*::           <tt>string</tt>
# *locked_at*::              <tt>datetime</tt>
# *created_at*::             <tt>datetime, not null</tt>
# *updated_at*::             <tt>datetime, not null</tt>
# *auth_token*::             <tt>string</tt>
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#--
# == Schema Information End
#++
