class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.string :uid
      t.string :provider
      t.string :image_url
      t.string :oauth_token
      t.string :oauth_refresh_token
      t.datetime :oauth_expires

      t.timestamps null: false
    end
  end
end
