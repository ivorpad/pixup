class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :title
      t.text :comment
      t.string :file_id
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
