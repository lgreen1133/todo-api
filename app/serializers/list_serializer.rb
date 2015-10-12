class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :permissions, :user_id

  has_many :items 
end
