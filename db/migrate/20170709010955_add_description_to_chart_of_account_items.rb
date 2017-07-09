class AddDescriptionToChartOfAccountItems < ActiveRecord::Migration[5.1]
  def change
    add_column :chart_of_account_items, :description, :text
  end
end
