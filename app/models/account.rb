class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :bank_name, :account, :agency
end
