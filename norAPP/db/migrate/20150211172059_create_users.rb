class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string "user_name", :limit => 25
    	t.string "email", :default => "", :null => false
    	t.string "password_diggest" #for storing incripted password
      	t.timestamps null: false
    end
  end
end
