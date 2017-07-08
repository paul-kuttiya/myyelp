describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns[:user]).to be_instance_of(User)
    end

    it "redirects to review listings if already signed in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "valid inputs" do
      let(:user) { Fabricate.attributes_for(:user) }
      
      before do
        post :create, user: user
      end

      it "saves user to DB" do
        expect(User.count).to eq 1
      end

      it "store user id in session" do
        expect(session[:user_id]).not_to be_nil
      end

      it "flashes welcome message" do
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "not valid inputs" do
      let(:user) {Fabricate.attributes_for(:user)}

      before do
        user["email"] = nil
        post :create, user: user
      end

      it "sets user" do
        expect(assigns[:user]).to be_instance_of User
      end 

      it "does not create user" do
        expect(User.count).to eq 0
      end

      it "returns error messages" do
        expect(assigns[:user].errors.full_messages.length).to eq 1
      end

      it "renders sign in form" do 
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }
    
    it "finds user" do
      get :show, { id: user.id }

      expect(assigns[:user]).to eq user
    end

    it "has review" do
      review = Fabricate(:review, user: user)

      get :show, { id: user.id }
      expect(assigns[:user].reviews).to match_array([review])
    end
  end
end