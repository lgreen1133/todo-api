class ListPolicy < ApplicationPolicy

  def update?
    user.present? && record.user.present? && (record.user == user || record.public?)
  end

end