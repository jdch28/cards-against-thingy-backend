class AddGameIdToSessios < ActiveRecord::Migration[6.0]
  def change
    add_reference :sessions, :game, index: true
  end
end
