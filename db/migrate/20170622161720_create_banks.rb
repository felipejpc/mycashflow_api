class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :cod

      t.timestamps
    end
  end
end
