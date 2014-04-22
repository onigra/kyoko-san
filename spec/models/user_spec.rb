require 'spec_helper'

describe User do

  let(:user) { Fabricate :sample_user }

  describe "#generate_token" do
    before { user.generate_token }
    subject { user.auth_token }

    it { should_not be_nil }
  end
  
  describe "#destroy_token" do
    before { user.destroy_token }
    subject { user.auth_token }

    it { should be_nil }
  end
end
