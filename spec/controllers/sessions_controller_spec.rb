describe SessionsController do
  describe "GET new" do
    it "renders log in page" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects if already signed in" do
      session[:user_id] = Fabricate(:user).id

      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }

    context "valid user" do
      before do  
        post :create, { email: user.email, password: user.password }
      end 

      it "stores user in session" do
        expect(session[:user_id]).to be user.id
      end

      it "flash success messages" do
        expect(flash[:success]).to be_present
      end

      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "invalid user" do
      before do
        post :create, { user: user.email, password: 'xxx' }
      end  

      it "flashes error message" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    
    it "destroys session" do
      expect(session[:user_id]).to be_nil
    end
    
    it "flash message" do
      expect(flash[:danger]).to be_present
    end
    
    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end
  end
end