class AddProfileDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :occupation, :string
    add_column :users, :study_tags, :string
    add_column :users, :instagram_id, :string
    add_column :users, :x_id, :string
    add_column :users, :tiktok_id, :string
  end
end
