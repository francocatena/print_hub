class AddAwesomeNestedSetAttributesToTags < ActiveRecord::Migration
  def change
    change_table(:tags) do |t|
      t.integer :lft
      t.integer :rgt
      t.integer :depth
    end
    
    Tag.rebuild! # Awesome! =)
  end
end
