class CreateBusinessHours < ActiveRecord::Migration[6.1]
  def change
    create_table :business_hours do |t|
      t.integer :day
      t.time :open_at
      t.time :close_at
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
