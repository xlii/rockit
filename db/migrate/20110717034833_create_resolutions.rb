class CreateResolutions < ActiveRecord::Migration
  def self.up
    create_table :resolutions do |t|
      t.string :name

      t.timestamps
    end

    ['open', 'closed', "won't fix"].each do |name|
      Resolution.create! :name => name
    end
  end

  def self.down
    drop_table :resolutions
  end
end
