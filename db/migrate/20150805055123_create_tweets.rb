class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user
      t.string :text, :limit => 140
      t.timestamps null: false
    end
  end
end
