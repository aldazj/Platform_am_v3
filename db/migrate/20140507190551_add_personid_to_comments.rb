class AddPersonidToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :person, index: true
  end
end
