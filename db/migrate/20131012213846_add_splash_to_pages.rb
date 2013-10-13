class AddSplashToPages < ActiveRecord::Migration
  def change
    add_column :pages, :splash, :boolean, :default => false
  end
end
