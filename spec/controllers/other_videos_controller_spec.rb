require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe OtherVideosController do

  # This should return the minimal set of attributes required to create a valid
  # OtherVideo. As you add validations to OtherVideo, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all other_videos as @other_videos" do
      other_video = OtherVideo.create! valid_attributes
      get :index
      assigns(:other_videos).should eq([other_video])
    end
  end

  describe "GET show" do
    it "assigns the requested other_video as @other_video" do
      other_video = OtherVideo.create! valid_attributes
      get :show, :id => other_video.id.to_s
      assigns(:other_video).should eq(other_video)
    end
  end

  describe "GET new" do
    it "assigns a new other_video as @other_video" do
      get :new
      assigns(:other_video).should be_a_new(OtherVideo)
    end
  end

  describe "GET edit" do
    it "assigns the requested other_video as @other_video" do
      other_video = OtherVideo.create! valid_attributes
      get :edit, :id => other_video.id.to_s
      assigns(:other_video).should eq(other_video)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new OtherVideo" do
        expect {
          post :create, :other_video => valid_attributes
        }.to change(OtherVideo, :count).by(1)
      end

      it "assigns a newly created other_video as @other_video" do
        post :create, :other_video => valid_attributes
        assigns(:other_video).should be_a(OtherVideo)
        assigns(:other_video).should be_persisted
      end

      it "redirects to the created other_video" do
        post :create, :other_video => valid_attributes
        response.should redirect_to(OtherVideo.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved other_video as @other_video" do
        # Trigger the behavior that occurs when invalid params are submitted
        OtherVideo.any_instance.stub(:save).and_return(false)
        post :create, :other_video => {}
        assigns(:other_video).should be_a_new(OtherVideo)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OtherVideo.any_instance.stub(:save).and_return(false)
        post :create, :other_video => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested other_video" do
        other_video = OtherVideo.create! valid_attributes
        # Assuming there are no other other_videos in the database, this
        # specifies that the OtherVideo created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        OtherVideo.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => other_video.id, :other_video => {'these' => 'params'}
      end

      it "assigns the requested other_video as @other_video" do
        other_video = OtherVideo.create! valid_attributes
        put :update, :id => other_video.id, :other_video => valid_attributes
        assigns(:other_video).should eq(other_video)
      end

      it "redirects to the other_video" do
        other_video = OtherVideo.create! valid_attributes
        put :update, :id => other_video.id, :other_video => valid_attributes
        response.should redirect_to(other_video)
      end
    end

    describe "with invalid params" do
      it "assigns the other_video as @other_video" do
        other_video = OtherVideo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OtherVideo.any_instance.stub(:save).and_return(false)
        put :update, :id => other_video.id.to_s, :other_video => {}
        assigns(:other_video).should eq(other_video)
      end

      it "re-renders the 'edit' template" do
        other_video = OtherVideo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OtherVideo.any_instance.stub(:save).and_return(false)
        put :update, :id => other_video.id.to_s, :other_video => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested other_video" do
      other_video = OtherVideo.create! valid_attributes
      expect {
        delete :destroy, :id => other_video.id.to_s
      }.to change(OtherVideo, :count).by(-1)
    end

    it "redirects to the other_videos list" do
      other_video = OtherVideo.create! valid_attributes
      delete :destroy, :id => other_video.id.to_s
      response.should redirect_to(other_videos_url)
    end
  end

end