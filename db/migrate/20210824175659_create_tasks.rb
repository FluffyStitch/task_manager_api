class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :text, null: false
      t.date :deadline
      t.integer :position
      t.boolean :completed, default: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
