require 'rails_helper'

RSpec.describe Task, type: :model do
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to have_many(:comments) }
end
