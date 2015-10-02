class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.string :title
      t.boolean :archived

      t.timestamps null: false
    end
  end
end
