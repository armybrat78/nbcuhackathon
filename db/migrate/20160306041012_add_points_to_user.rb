class AddPointsToUser < ActiveRecord::Migration
  def up
    execute " ALTER TABLE users
              ADD COLUMN points integer DEFAULT 0;
    "
  end

  def down
    execute "ALTER TABLE users
            DROP COLUMN IF EXISTS points;
    "
  end
end
