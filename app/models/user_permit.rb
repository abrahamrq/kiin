class UserPermit < ActiveRecord::Base

  validates_format_of :granting_user, with: /([Aa]\d{8})/
  validates_format_of :granted_user, with: /([Aa]\d{8})/

  validates :granting_user, presence: true
  validates :granted_user, presence: true, uniqueness: {scope: :granting_user}
end