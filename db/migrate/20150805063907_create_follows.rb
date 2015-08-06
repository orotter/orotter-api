class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :to_user_id  , index: true
      t.integer :from_user_id, index: true
      t.timestamps null: false
    end
  end
end
