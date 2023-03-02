# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  read       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:read).of_type(:boolean) }
    it { should have_db_index([:user_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:user) }
  end
end
