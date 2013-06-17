class RenamePersonalPostingToPersonalposting < ActiveRecord::Migration
  def change
    rename_table :personal_postings, :personalpostings
  end
end
