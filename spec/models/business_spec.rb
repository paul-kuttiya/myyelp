describe Business do
  it { should have_many :reviews }

  describe "#reviews_count" do
    it "returns total reviews size" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business: business)
      review2 = Fabricate(:review, business: business)

      expect(business.reviews_count).to eq 2
    end
  end
  
  describe "#last_review" do
    it "returns last review" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business: business, created_at: 2.days.ago)
      review2 = Fabricate(:review, business: business)

      expect(business.last_review).to eq review2.description
    end
  end

  describe "#last_reviewer" do
    it "returns last reviewer" do
      business = Fabricate(:business)
      user = Fabricate(:user)
      review1 = Fabricate(:review, business: business, created_at: 2.days.ago)
      review2 = Fabricate(:review, business: business, user: user)

      expect(business.last_reviewer).to eq user
    end
  end

  describe "#rating" do
    it "returns avarage ratings for business" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, rating: 1, business: business)
      review2 = Fabricate(:review, rating: 3)

      expect(business.rating).to eq 2
    end
  end
end