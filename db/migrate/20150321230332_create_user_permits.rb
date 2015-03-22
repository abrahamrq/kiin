class CreateUserPermits < ActiveRecord::Migration
  def change
    create_table :user_permits do |t|
      t.string :granting_user
      t.string :granted_user

      t.timestamps
    end
  end
end
