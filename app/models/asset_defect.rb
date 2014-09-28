class AssetDefect < ActiveRecord::Base
  
  belongs_to :asset
  belongs_to :reporter,   :class_name => 'Staff', :foreign_key => 'reported_by'
  belongs_to :processor,  :class_name => 'Staff', :foreign_key => 'processed_by'
  belongs_to :confimer,   :class_name => 'Staff', :foreign_key => 'decision_by'
  
  validates :asset, :presence => true
  validates :processed_by, :process_type, :processed_on, presence: true, :if => :check_processed?
  validates :decision_by, :decision_on, presence: true, :if => :check_decision?
  
  def check_processed?
    is_processed == true
  end
  
  def check_decision?
    decision == true
  end
  
end

# == Schema Information
#
# Table name: asset_defects
#
#  asset_id       :integer
#  created_at     :datetime
#  decision       :boolean
#  decision_by    :integer
#  decision_on    :date
#  description    :text
#  id             :integer          not null, primary key
#  is_processed   :boolean
#  notes          :text
#  process_type   :string(255)
#  processed_by   :integer
#  processed_on   :date
#  recommendation :text
#  reported_by    :integer
#  updated_at     :datetime
#
