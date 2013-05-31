require 'spec_helper'

describe 'donating', type: 'feature' do

  def post_checkout
    page.driver.post '/donations/checkout', params
  end

  let(:params) do
    {donation:
         {amount: 12300, package: 'Custom'}}
  end

  before :each do
    stub_stripe_methods
    post_checkout
  end

  describe 'checkout page' do
    FORM_FIELDS = ['name', 'email', 'twitter_handle', 'github_handle', 'homepage',
                   'comment']




    it 'displays the donate now button on the page' do
      page.should have_content /donate/i
    end

    it 'displays your donation amount on the page' do
      page.should have_content "#{params[:donation][:amount]/100}.00"
    end

    it 'should have the new donation form' do
      FORM_FIELDS.each do |field_name|
        page.should have_field 'donation_' + field_name
      end
    end
  end

  describe 'confirm page' do
    before :each do
      click_on 'Donate now'
    end

    it 'thanks the donor' do
      page.should have_content /thank you/i
    end
  end

end