class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :status, default: 'new'
      t.string :creator
      t.string :performer
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
