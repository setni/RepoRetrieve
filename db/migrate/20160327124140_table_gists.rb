class TableGists < ActiveRecord::Migration
  def change
      #drop_table :gists
      create_table :gists
      add_column :gists, :link, :string
      add_column :gists, :name, :string
      add_column :gists, :category, :string
      add_column :gists, :id_github, :integer
  end
end
