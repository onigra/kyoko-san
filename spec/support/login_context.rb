shared_context "login" do
  let(:user) { Fabricate :sample_user }
  before { user.generate_token }
end
