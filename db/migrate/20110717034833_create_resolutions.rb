class CreateResolutions < ActiveRecord::Migration
  def self.up
    create_table :resolutions do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :resolutions
  end
end
