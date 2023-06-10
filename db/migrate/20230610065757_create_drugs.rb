# frozen_string_literal: true

class CreateDrugs < ActiveRecord::Migration[7.0]
  def change
    create_table :drugs do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.float :price, null: false
      t.string :description, null: false
      t.string :company, null: false
      t.datetime :deadline, null: false

      t.timestamps
    end

    add_index :drugs, %i[name price deadline company], unique: true
  end
end
