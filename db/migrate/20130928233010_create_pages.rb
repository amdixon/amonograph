class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :file
      t.string :title
      t.text :content
      t.integer :position
      t.integer :portfolio_id
      
      t.timestamps
    end
  end
end
