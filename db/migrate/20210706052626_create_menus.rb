class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
