class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.text :description
      t.string :number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
