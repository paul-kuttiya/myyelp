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

  describe "GET new" do
    describe "non user" do
      it_behaves_like "required signed in user" do
        let(:action) { get :new }
      end
    end

    describe "user" do
      it "render new business form" do
        set_user
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST create" do
    describe "non user" do
      it_behaves_like "required signed in user" do
        let(:action) { post :create }
      end
    end

    describe "user" do
      let(:business) { Fabricate.attributes_for(:business) }

      before do
        set_user
        post :create, business: business
      end

      it "sets business" do
        post :create, business: business

        expect(assigns[:business]).to be_instance_of(Business)
      end

      context "valid inputs" do
        it "saves business to db" do
          expect(Business.first).to eq assigns[:business]
        end

        it "flashes success message" do
          expect(flash[:success]).to be_present
        end

        it "redirects to business page" do
          expect(response).to redirect_to assigns[:business]
        end
      end

      context "invalid inputs" do
        let(:business) { Fabricate.attributes_for(:business, address: nil) }

        before do
          set_user
          post :create, business: business
        end

        it "renders new business form" do
          expect(response).to render_template :new
        end

        it "shows form errors" do
          expect(assigns[:business].errors.full_messages[0]).to be_present
        end

        it "does not save to db" do
          expect(Business.count).to eq 0
        end
      end
    end
  end
end