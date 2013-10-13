class AddFileWidthToPages < ActiveRecord::Migration
  def change
    add_column :pages, :web_width, :integer
    add_column :pages, :web_height, :integer
    add_column :pages, :mobile_width, :integer
    add_column :pages, :mobile_height, :integer
  end
end
