class RemoveBankNameFromAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :description, :text
    remove_column :accounts, :bank_name, :string
  end
end
