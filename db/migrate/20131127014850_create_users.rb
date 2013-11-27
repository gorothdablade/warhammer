class CreateUsers < ActiveRecord::Migration
  def change
    create_table  :users do |t|
      t.string    :email
      t.string    :first_name
      t.string    :last_name
      t.string    :nickname
      t.string    :password_digest
      t.string    :registration_key
      t.string    :password_reset_key
      t.datetime  :registered_at
    end
  end
end
