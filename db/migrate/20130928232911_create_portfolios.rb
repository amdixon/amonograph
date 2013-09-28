class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :content
      t.integer :position
      t.integer :user_id

      t.timestamps
    end
  end
end
