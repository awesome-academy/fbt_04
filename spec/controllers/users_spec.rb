# spec/controllers/users_controller.rb
require "rails_helper"
require "./app/helpers/sessions_helper"

RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe UsersController, type: :controller do
  let!(:user) {FactoryGirl.create :user}
  let! :user_param do
    {
      fullname: Faker::Name.name,
      email: "user@example.com",
      password: "123456",
      password_confirmation: "123456"
    }
  end

  describe "GET #new" do
    before {get :new}

    it "when require login return 200" do
      expect(response).to have_http_status :success
    end

    it "when not logged" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when created success" do
      before {post :create, params: {user: user_param}}

      it "return flash success" do
        expect(flash[:success]).to match(I18n.t("controllers.signup.success"))
      end

      it "return root path" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when create fail" do
      before do
        user_param[:fullname] = ""
        user_param[:email] = "user@gmail,com"
        user_param[:password] = "123"
        user_param[:password_confirmation] = "123456"
        post :create, params: {user: user_param}
      end

      it "return flash danger" do
        expect(flash[:danger]).to match(I18n.t("controllers.signup.fail"))
      end

      it "return acction new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #show" do
    before {get :show, params: {id: user.id}}

    context "when found any review" do
      it "return status" do
        expect(response).to_not include(have_http_status :success)
      end

      it "return template show" do
        expect(response).to_not include(render_template("users/show"))
      end
    end

    context "when not found any review" do
      it "return flash danger" do
        expect(flash[:danger]).to match(I18n.t("controllers.reviews.notfound"))
      end
    end
  end

  describe "GET #edit" do
    context "when logged" do
      before do
        log_in user
        get :edit, params: {id: user.id}
      end

      it "return template edit page" do
        expect(response).to render_template :edit
      end
    end

    context "when not login" do
      before do
        user.id -= 1
        get :edit, params: {id: user.id}
      end

      it "return template" do
        expect(response).to redirect_to(login_path)
      end
    end

    context "when don't correct user" do
      before do
        log_in user
        user.id -= 1
        get :edit, params: {id: user.id}
      end

      it "return template" do
        expect(response).to redirect_to current_user
      end
    end
  end

  describe "PATCH #update" do
    context "when updated" do
      before do
        log_in user
        user_param[:fullname] = "Trần Ngọc Tấn"
        user_param[:email] = "ngoctan9811@gmail.com"
        user_param[:password] = "password"
        user_param[:password_confirmation] = "password"
        patch :update, params: {id: user.id, user: user_param}
      end

      it "return flash success" do
        expect(flash[:success]).to match(I18n.t("controllers.users.profiless"))
      end

      it "return redirect_to user" do
        expect(response).to redirect_to user
      end
    end

    context "when update is fail" do
      before do
        log_in user
        user_param[:fullname] = ""
        user_param[:email] = "ngoctan9811@gmail,com"
        user_param[:password] = "password"
        user_param[:password_confirmation] = "123456"
        patch :update, params: {id: user.id, user: user_param}
      end

      it "return flash danger" do
        expect(flash[:danger]).to match(I18n.t("controllers.users.profilefail"))
      end

      it "return some messages errors" do
        expect(assigns(:user).errors.full_messages.count).to be >= 3
      end

      it "return render template edit" do
        expect(response).to render_template :edit
      end
    end
  end
end
