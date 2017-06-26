##
# This class representing a MyCashFlow Bank. In this class you'll
# find the bank method's.
class Bank < ApplicationRecord
##
# Relationship with accounts  
  has_many :accounts, dependent: :destroy

  validates_presence_of :cod, :name
  validates :cod, uniqueness: { case_sensitive: false }

##
# Return basic information about a bank instance
  def info
    "#{cod} - #{name}"
  end
end
