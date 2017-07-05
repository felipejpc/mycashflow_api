class CreateChartOfAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :chart_of_accounts do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
