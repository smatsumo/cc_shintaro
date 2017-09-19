class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :image1
      t.string :image2
      t.string :image3
      t.integer :status , limit:1
      t.references :category, foreign_key: true, limit:1
      t.references :user, foreign_key: true, limit:1

      t.timestamps
    end
  end
end
