class List < ActiveRecord::Base
  belongs_to :user
  has_many :items 

  validates :name, presence: true
  validates :permissions, inclusion: { in: %w(private viewable open),
    message: "%{value} is not valid" }
end
