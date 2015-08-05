class AddNoenvToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :noenv, :boolean unless column_exists? :hosts, :noenv
  end
end
