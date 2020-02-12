class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :text
      t.integer :card_type

      t.timestamps
    end
  end
end
