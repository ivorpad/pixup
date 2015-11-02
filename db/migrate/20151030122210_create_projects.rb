class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.boolean :favorite, default: false

      t.timestamps null: false
    end
  end
end
