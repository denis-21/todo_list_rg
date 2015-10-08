require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to have_many(:projects) }

  describe '#facebook_login' do
    let(:auth) do
      user = attributes_for :facebook_user
      double("auth",
             provider: user[:provider],
             uid: user[:uid],
             info: double("info",
                          email: user[:email],

             )
      )
    end

    it 'create new user' do
      expect(User.facebook_login(auth)).to be_instance_of(User)
    end

    it 'user have email' do
      expect(User.facebook_login(auth)).to respond_to(:email)
    end

    it 'user have password' do
      expect(User.facebook_login(auth)).to respond_to(:password)
    end

  end
end
