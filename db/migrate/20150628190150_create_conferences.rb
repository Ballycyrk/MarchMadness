class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.text    :con_name
      t.text    :con_nickname
      t.integer :founded
      t.integer :members
      t.text    :headquarters

      t.timestamps null: false
    end
  end
end
