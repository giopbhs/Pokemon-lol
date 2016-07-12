class CreateComents < ActiveRecord::Migration
  def change
    create_table :coments do |t|
      t.integer :pin_id
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :coments, :pin_id
  end
end
