class AddStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :text
    add_column :tasks, :start_at, :datetime
    add_column :tasks, :end_at, :datetime
    change_column :tasks, :title, :string, null:false
    change_column :tasks, :content, :string, null:false
  end
  end
