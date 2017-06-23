class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #  :confirmable, :lockable
  
  validates :email, uniqueness: { case_sensitive: false }
  validates_uniqueness_of :auth_token

  def info
    "#{email} - #{created_at}"        
  end

end
