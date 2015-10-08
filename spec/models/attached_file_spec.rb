require 'rails_helper'

RSpec.describe AttachedFile, type: :model do
  it { expect(subject).to belong_to(:comment) }
end
