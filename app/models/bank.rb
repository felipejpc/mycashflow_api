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

# == Schema Information
#
# Table name: banks
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *cod*::        <tt>string</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
