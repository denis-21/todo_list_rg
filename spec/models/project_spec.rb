require 'rails_helper'

RSpec.describe Project, type: :model do
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to have_many(:tasks) }
  it { expect(subject).to belong_to(:user) }
end
