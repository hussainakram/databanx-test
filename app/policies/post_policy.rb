# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def update?
    user === record.author
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
