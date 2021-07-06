class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
