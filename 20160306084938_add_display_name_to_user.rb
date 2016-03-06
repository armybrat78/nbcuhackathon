class AddDisplayNameToUser < ActiveRecord::Migration
  def up
    execute " ALTER TABLE users
              ADD COLUMN display_name varchar(20) NOT NULL
    "
  end
  def down
    execute " ALTER TABLE users
              DROP COLUMN IF EXISTS display_name
    "
  end
end
