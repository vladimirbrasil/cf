class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :username
      t.string :location
      t.string :image_url
      t.string :url
      t.string :oauth_token
      t.string :oauth_refresh_token
      t.string :oauth_secret
      t.datetime :oauth_expires

      t.timestamps null: false
    end
  end
end
