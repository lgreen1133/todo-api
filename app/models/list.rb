class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy 

  validates :name, presence: true
  validates :permissions, inclusion: { in: %w(private viewable open),
    message: "%{value} is not valid" }

  # scope :filter_by_name, lambda { |keyword| 
  #   where("lower(title) LIKE ?", "%#{keyword.downcase}%")
  # }

  def public?
    permissions == 'open'
  end

  # moving search action to controller for now 
  
  # def self.search(search)
  #   if search 
  #     where('name LIKE ?', "%#{name}%")
  #   else
  #     scoped
  #   end
  # end

  # def self.search(params = {})
  #   lists = params[:list_ids].present? ? List.find(params[:list_ids]) : lists 

  #   lists = lists.filter_by_name(params[:keyword]) if params[:keyword]

  #   lists 
  # end
end
