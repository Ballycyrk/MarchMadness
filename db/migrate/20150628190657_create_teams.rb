class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.text :school
      t.text :mascot
      t.text :team_city
      t.text :team_state
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
