# frozen_string_literal: true

class Resume < ApplicationRecord
  validates :name, presence: true
  validates :contact, presence: true

  # BEGIN
  has_many :educations, dependent: :destroy, class_name: 'ResumeEducation'
  has_many :works, dependent: :destroy, class_name: 'ResumeWork'

  accepts_nested_attributes_for :educations, :works
  # END
end