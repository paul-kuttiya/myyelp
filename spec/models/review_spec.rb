describe Review do
  it { should belong_to :user }
  it { should belong_to :business }
  it { should validate_presence_of :rating }
  it { should validate_presence_of :description }
  it { should ensure_length_of(:description) }

  define "#user_name" do
    it "returns reviewer first name" do
      user = Fabricate(:user)
      review = Fabricate(:review, user: user)
      expect(review.user_name).to eq user.first_name
    end
  end

  define "#business_name" do
    it "returns busines name" do
      business = Fabricate(:business)
      review = Fabricate(:review, business: business)
      expect(review.business_name).to eq business.name
    end
  end
end