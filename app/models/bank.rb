class Bank < ApplicationRecord
  has_many :accounts, dependent: :destroy

  validates_presence_of :cod, :name
  validates :cod, uniqueness: { case_sensitive: false }

  def info
    "#{cod} - #{name}"
  end
end
