class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.belongs_to :task, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
