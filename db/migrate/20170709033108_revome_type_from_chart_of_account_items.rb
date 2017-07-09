class RevomeTypeFromChartOfAccountItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :chart_of_account_items, :type, :string
    add_column :chart_of_account_items, :accounting_category, :string
  end
end
