require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe StoresController do

  def mock_store(stubs={})
    @mock_store ||= mock_model(Store, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all stores as @stores" do
      Store.stub(:all) { [mock_store] }
      get :index
      assigns(:stores).should eq([mock_store])
    end
  end

  describe "GET show" do
    it "assigns the requested store as @store" do
      Store.stub(:get).with("37") { mock_store }
      get :show, :id => "37"
      assigns(:store).should be(mock_store)
    end
  end

  describe "GET new" do
    it "assigns a new store as @store" do
      Store.stub(:new) { mock_store }
      get :new
      assigns(:store).should be(mock_store)
    end
  end

  describe "GET edit" do
    it "assigns the requested store as @store" do
      Store.stub(:get).with("37") { mock_store }
      get :edit, :id => "37"
      assigns(:store).should be(mock_store)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created store as @store" do
        Store.stub(:new).with({'these' => 'params'}) { mock_store(:save => true) }
        post :create, :store => {'these' => 'params'}
        assigns(:store).should be(mock_store)
      end

      it "redirects to the created store" do
        Store.stub(:new) { mock_store(:save => true) }
        post :create, :store => {}
        response.should redirect_to(store_url(mock_store))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        Store.stub(:new).with({'these' => 'params'}) { mock_store(:save => false) }
        post :create, :store => {'these' => 'params'}
        assigns(:store).should be(mock_store)
      end

      it "re-renders the 'new' template" do
        Store.stub(:new) { mock_store(:save => false) }
        post :create, :store => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested store" do
        Store.stub(:get).with("37") { mock_store }
        mock_store.should_receive(:update).with({'these' => 'params'})
        put :update, :id => "37", :store => {'these' => 'params'}
      end

      it "assigns the requested store as @store" do
        Store.stub(:get) { mock_store(:update => true) }
        put :update, :id => "1"
        assigns(:store).should be(mock_store)
      end

      it "redirects to the store" do
        Store.stub(:get) { mock_store(:update => true) }
        put :update, :id => "1"
        response.should redirect_to(store_url(mock_store))
      end
    end

    describe "with invalid params" do
      it "assigns the store as @store" do
        Store.stub(:get) { mock_store(:update => false) }
        put :update, :id => "1"
        assigns(:store).should be(mock_store)
      end

      it "re-renders the 'edit' template" do
        Store.stub(:get) { mock_store(:update => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested store" do
      Store.stub(:get).with("37") { mock_store }
      mock_store.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the stores list" do
      Store.stub(:get) { mock_store }
      delete :destroy, :id => "1"
      response.should redirect_to(stores_url)
    end
  end

end
