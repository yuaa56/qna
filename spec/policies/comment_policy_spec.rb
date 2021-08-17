require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
    # let(:user) { User.new }
    let(:user) { create :user }


  subject { described_class }

    permissions :update? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin:true), create(:comment))
    end
 
    it 'grants access if user is author' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

   it 'denied access if user is not author' do
    expect(subject).not_to permit(User.new, create(:comment, user: user))
   end
  end

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin:true), create(:comment))
     end
  
     it 'grants access if user is author' do
      expect(subject).to permit(user, create(:comment, user: user))
     end
 
    it 'denied access if user is not author' do
      expect(subject).not_to permit(User.new, create(:comment, user: user))
    end
   end
end
