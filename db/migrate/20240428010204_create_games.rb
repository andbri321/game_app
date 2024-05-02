# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :total_kills, default: 0
      t.text :players, array: true, default: []
      t.jsonb :kills, default: {}
      t.jsonb :kills_by_means, default: {}

      t.timestamps
    end
  end
end
