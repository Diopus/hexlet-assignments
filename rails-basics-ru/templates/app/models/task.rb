# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  completed   :boolean          default(FALSE)
#  creator     :string
#  description :text
#  name        :string
#  performer   :string
#  status      :string           default("new")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
end
