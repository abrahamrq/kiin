class CreateUserPermits < ActiveRecord::Migration
  def change
    create_table :user_permits do |t|
      t.integer :granting_user
      t.integer :granted_user

      t.timestamps
    end
  end
end
