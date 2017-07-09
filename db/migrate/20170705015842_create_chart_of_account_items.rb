class CreateChartOfAccountItems < ActiveRecord::Migration[5.1]
  def change
    create_table :chart_of_account_items do |t|
      t.string :name
      t.string :type
      t.references :ancestor, index: true
      t.references :chart_of_account, foreign_key: true

      t.timestamps
    end
  end
end
