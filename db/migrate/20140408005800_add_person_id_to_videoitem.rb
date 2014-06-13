class AddPersonIdToVideoitem < ActiveRecord::Migration
  def change
    add_reference :videoitems, :person, index: true
  end
end
