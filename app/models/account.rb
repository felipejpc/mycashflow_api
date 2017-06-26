##
# This class representing a MyCashFlow User's Account. 
# In this class you'll find all Account method's.
class Account < ApplicationRecord

##
# Account relations
  belongs_to :user
  belongs_to :bank

  validates_presence_of :bank_name, :account, :agency
end
