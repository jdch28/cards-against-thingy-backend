class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :pin
      t.integer :status, default: 0
      t.datetime :end_date
      t.timestamps
    end
  end
end
