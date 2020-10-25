class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :cohort

      t.timestamps
    end
  end
end
