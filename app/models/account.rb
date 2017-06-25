class Account < ApplicationRecord
  belongs_to :user
  belongs_to :bank

  validates_presence_of :bank_name, :account, :agency
end
