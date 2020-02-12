class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :token

      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end
