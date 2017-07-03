describe BusinessesController do
  describe "GET index" do
    it "has businesses array" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)

      get :index
      expect(assigns[:businesses].size).to be 2
    end

    it "orders business DESC" do
      business1 = Fabricate(:business, created_at: 3.days.ago)
      business2 = Fabricate(:business, created_at: 2.days.ago)
      business3 = Fabricate(:business, created_at: 1.days.ago)            

      get :index
      expect(assigns[:businesses]).to match_array [business3, business2, business1]
    end 
  end

  describe "GET show" do
    let(:business) { Fabricate(:business) }
    let(:user) { Fabricate(:user) }

    it "finds business" do
      get :show, { id: business.id }
      expect(assigns[:business]).to eq business
    end

    it "has reviews for business" do
      review1 = Fabricate(:review, user: user, business: business)
      review2 = Fabricate(:review, user: user, business: business)

      get :show, { id: business.id }
      expect(assigns[:reviews]).to match_array([review1, review2])
    end

    it "has user for each review" do
      review1 = Fabricate(:review, user: user, business: business)
      review2 = Fabricate(:review, user: user, business: business)

      get :show, { id: business.id }
      expect(assigns[:reviews].map(&:user)).to match_array([user, user])
    end

    it "returns empty reviews array if no any review" do
      get :show, { id: business.id }
      expect(assigns[:reviews]).to eq []
    end
  end
end