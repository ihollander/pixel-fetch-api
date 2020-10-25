class CreateSnapshots < ActiveRecord::Migration[6.0]
  def change
    create_table :snapshots do |t|
      t.binary :board
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
