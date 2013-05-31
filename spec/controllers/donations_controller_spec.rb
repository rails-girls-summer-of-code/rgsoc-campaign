require 'spec_helper'

describe DonationsController do

  before :each do
    stub_stripe_methods
  end

  let(:params) do
    {'donation' => {'package' => 'Custom', 'amount'  => '5000'}}
  end

  describe 'POST #create' do
    it 'does not display donations when the hide checkbox was checked' do
      post :create, params.merge({'donation' => {'hide'=> '1'}})
      assigns(:donation).display.should be_false
    end

    it 'does display donations when the hide checkbox was not checked' do
      post :create, params['donation'].merge({'donation' => {'hide'=> '0'}})
      assigns(:donation).display.should be_true
    end
  end

end