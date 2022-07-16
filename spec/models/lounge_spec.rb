require 'rails_helper'

RSpec.describe Lounge, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:address_street_1).of_type(:string) }
    it { should have_db_column(:address_street_2).of_type(:string) }
    it { should have_db_column(:city).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:zip_code).of_type(:string) }
    it { should have_db_column(:opening_time).of_type(:time) }
    it { should have_db_column(:closing_time).of_type(:time) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_index([:user_id]) }
  end
end
