describe User do
  it { should have_many :reviews }
  it { should have_secure_password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }

  describe "#full_name" do
    it "returns full name" do
      user = Fabricate(:user, first_name: "Andy", last_name: "Wong")
      expect(user.full_name).to eq "Andy Wong"
    end
  end

  describe "#total_reviews" do
    it "returns user total reviews" do
      user = Fabricate(:user)
      review1 = Fabricate(:review, user: user)
      review2 = Fabricate(:review, user: user)
      expect(user.total_reviews).to eq 2
    end
  end

  describe "#existing_review?" do
    it "returns true if user already review a business" do
      user = Fabricate(:user)
      business = Fabricate(:business)
      review = Fabricate(:review, business: business, user: user)
      expect(user.existing_review?(business)).to eq review
    end
  end
end  