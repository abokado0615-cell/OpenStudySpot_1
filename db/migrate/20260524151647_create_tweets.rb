class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.time :time
      t.string :progress
      t.text :question

      t.timestamps
    end
  end
end
