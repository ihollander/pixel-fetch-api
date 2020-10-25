class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.integer :x
      t.integer :y
      t.integer :r
      t.integer :g
      t.integer :b
      t.integer :a
      t.string :ip
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
