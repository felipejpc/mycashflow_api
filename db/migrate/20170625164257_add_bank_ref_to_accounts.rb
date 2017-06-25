class AddBankRefToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :bank, foreign_key: true
  end
end
