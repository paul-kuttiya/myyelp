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
        set_user(user)
        get :new, { business_id: business.id }
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
      it_behaves_like "required signed in user" do
        let(:action) { get :new, { business_id: 1 } }
      end
    end
  end

  describe "POST create" do
    describe "non user" do
      let(:review) { Fabricate.attributes_for(:review) }
      let(:business) { Fabricate(:business) }

      it_behaves_like "required signed in user" do
        let(:action) { post :create, { business_id: business.id, review: review } }
      end
    end

    describe "user" do
      let(:user) { Fabricate(:user) }
      let(:business) { Fabricate(:business) }
      let(:review) { Fabricate.attributes_for(:review, user: user, business: business) }

      before do
        set_user(user)
        post :create, { business_id: business.id, review: review }
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
        set_user

        business = Fabricate(:business)
        review = Fabricate.attributes_for(:review, rating: nil)

        post :create, { business_id: business.id, review: review }
        expect(response).to redirect_to new_business_review_path
      end
    end
  end

  describe "GET edit" do
    let(:business) { Fabricate(:business) }
    let(:review) { Fabricate(:review) }

    describe "non-user" do
      it_behaves_like "required signed in user" do
        let(:action) { get :edit, { business_id: business.id, id: review.id } }
      end
    end
    
    describe "user" do
      it "finds review" do
        set_user
        get :edit, { business_id: business.id, id: review.id }
        expect(assigns[:review]).to eq review
      end
    end
  end

  describe "PATCH update" do
    let(:business) { Fabricate(:business) }
    let(:review) { Fabricate(:review) }

    describe "non user" do
      it_behaves_like "required signed in user" do
        let(:action) { patch :update, { business_id: business.id, id: review.id } }
      end
    end

    describe "user" do
      let(:user) { Fabricate(:user) }

      before do
        set_user(user)
      end

      it "finds review" do
        business = Fabricate(:business)
        review = Fabricate(:review, user: user, business: business)
        patch :update, { business_id: business.id, id: review.id, review: Fabricate.attributes_for(:review) }
        
        expect(Review.find(review.id)).to eq review
      end

      context "valid inputs" do
        let(:business) { Fabricate(:business) }
        let(:review) { Fabricate(:review) }
        let(:update_review) { Fabricate.attributes_for(:review) }

        before do
          patch :update, { business_id: business.id, id: review.id, review: update_review }
        end

        it "update attributes" do
          expect(assigns[:review].rating).to eq update_review["rating"]
          expect(assigns[:review].description).to eq update_review["description"]
        end

        it "redirects to business page" do
          expect(response).to redirect_to business
        end
      end

      context "invalid inputs" do
        let(:business) { Fabricate(:business) }
        let(:review) { Fabricate(:review) }
        let(:update_review) { Fabricate.attributes_for(:review, rating: nil) }

        before do
          patch :update, { business_id: business.id, id: review.id, review: update_review }
        end

        it "flashes message" do
          expect(flash[:danger]).to be_present
        end

        it "redirects to edit review page" do
          expect(response).to redirect_to edit_business_review_path(business, review)
        end
      end
    end
  end
end