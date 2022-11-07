require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many_attached(:uploads) }
  end

  describe 'validations' do
    subject { build(:user) }
    
    describe '#email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }

      it { should_not (allow_value('does-not-have-at.com').for(:email)) }
      it { should_not (allow_value('something@has_at').for(:email)) }

      it { should_not(allow_value('only_with.com').for(:email)) }
      it { should (allow_value('correct@email.org').for(:email)) }
    end
  end

  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
end
