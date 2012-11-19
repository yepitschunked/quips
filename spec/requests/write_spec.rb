require 'spec_helper'

describe 'Creating a new quip' do
  it 'should let you create a new quip' do
    visit new_quip_path
    attrs = FactoryGirl.attributes_for(:quip, quip: 'this is a new quip')
    [:source, :submitter, :quip, :date].each do |field|
      fill_in field, with: attrs[field.to_s].to_s
    end

    click_on 'Create Quip'
    page.should have_content attrs['quip']
    page.should have_content attrs['source']
    page.should have_content attrs['submitter']
    page.should have_content attrs['date'].to_s
  end
end
