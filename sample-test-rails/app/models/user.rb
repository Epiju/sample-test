# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  name     :string(100)      not null
#  password :string(100)      not null
#  email    :string(100)      not null
#  group_id :integer          not null
#  token    :string(255)
#

class User < ActiveRecord::Base
  has_secure_token
  has_many :attends
  has_many :events
end
