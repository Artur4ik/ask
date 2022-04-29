class Like < ApplicationRecord
  scope :targeted_list ->() { |target_id, target_type| where(....) }
end
