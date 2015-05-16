# == Schema Information
#
# Table name: attends
#
#  user_id     :integer          not null
#  event_id    :integer          not null
#  reserved_at :datetime         default("CURRENT_TIMESTAMP"), not null
#

class Attend < ActiveRecord::Base
  has_one :user
  has_one :event
  default_value_for :reserved_at do
    Time.zone.now.to_i
  end

end
