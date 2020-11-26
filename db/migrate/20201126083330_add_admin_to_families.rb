class AddAdminToFamilies < ActiveRecord::Migration[6.0]
  def change
    add_reference :families, :familyadmin, foreign_key: { to_table: :users }
    Family.all.each {|f| f.update(familyadmin_id: f.users[0].id)}
  end
end
