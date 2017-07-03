describe ReviewsController do
  describe "GET index" do
    it "has array of reviews" do
      review1 = Fabricate(:review)
      review2 = Fabricate(:review)

      get :index
      expect(assigns[:reviews].size).to be 2
    end

    it "orders reviews DESC" do
      review1 = Fabricate(:review, created_at: 3.days.ago)
      review2 = Fabricate(:review, created_at: 2.days.ago)
      review3 = Fabricate(:review, created_at: 1.days.ago)

      get :index
      expect(assigns[:reviews]).to match_array [review3,review2,review1]
    end
  end

  describe "GET new" do
    context "logged in user" do
      let(:user) { Fabricate(:user) }
      let(:business) { Fabricate(:business) }

      before do
        session[:user_id] = user.id
        get :new, { id: business.id }
      end
      
      it "finds business" do
        expect(assigns[:business]).to eq business
      end

      it "sets review instances" do
        expect(assigns[:review]).to be_instance_of Review
      end

      it "renders new" do
        expect(response).to render_template :new
      end
    end

    context "non user" do
      it "redirects to login" do
        get :new, { id: 1 }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    describe "non user" do
      let(:review) { Fabricate.attributes_for(:review) }
      let(:business) { Fabricate(:business) }

      it "redirects to login" do
        post :create, { id: business.id, review: review }

        expect(response).to redirect_to login_path
      end
    end

    describe "user" do
      let(:user) { Fabricate(:user) }
      let(:business) { Fabricate(:business) }
      let(:review) { Fabricate.attributes_for(:review, user: user, business: business) }

      before do
        session[:user_id] = user.id
        post :create, { id: business.id, review: review }
      end

      it "constructs review instance" do
        expect(assigns[:review]).to be_instance_of Review
      end

      context "valid input" do
        it "saves review" do
          expect(Review.count).to eq 1
        end

        it "flash message" do
          expect(flash[:success]).to be_present
        end
        
        it "redirects to business page" do
          expect(response).to redirect_to business
        end
      end

    end
    
    context "invalid input" do
      it "redirects to new review page" do
        user = Fabricate(:user)
        session[:user_id] = user.id

        business = Fabricate(:business)
        review = Fabricate.attributes_for(:review, rating: nil)

        post :create, { id: business.id, review: review }
        expect(response).to redirect_to review_business_path
      end
    end
  end 
end
