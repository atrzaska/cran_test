# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.string :title
      t.string :description
      t.string :author
      t.string :version
      t.string :maintainer
      t.string :license
      t.datetime :publication_date

      t.timestamps
    end
  end
end
