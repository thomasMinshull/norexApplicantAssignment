class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :user_tables do |t|
    	t.string "user_name", :limit => 25
    	t.string "email", :default => "", :null => false
    	t.timestamps
    	#t.string "password_diggest" #requires "has_secure_pasword" in associated model
    end
  end
end