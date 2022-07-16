class Lounge < ApplicationRecord
  belongs_to :user
  has_rich_text :details
end
