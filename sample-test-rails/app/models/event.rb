# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(100)      not null
#  start_date :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attends
end
