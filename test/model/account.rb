ActiveRecord::Base.connection.create_table(:accounts, force: true) do |t|
  t.integer :age
  t.string :site
  t.integer :user_id
  t.timestamps null: false
end

class Account < ActiveRecord::Base
  acts_as_cached expires_in: 3.days
  belongs_to :user
end
