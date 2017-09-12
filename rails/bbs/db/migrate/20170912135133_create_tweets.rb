class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :tweet

      t.timestamps
    end
  end
end
