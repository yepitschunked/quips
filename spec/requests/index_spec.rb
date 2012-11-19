require 'spec_helper'

describe 'Viewing all quips' do
  it 'should show quips and their details' do
    @quip = FactoryGirl.create(:quip, votes: 54321)
    visit '/'
    page.should have_content @quip.quip
    page.should have_content '54321'
  end
end

describe 'sorting' do
  it 'should sort by highest rated' do
    quips = [FactoryGirl.create(:quip, votes: 54321), FactoryGirl.create(:quip, votes: 50), FactoryGirl.create(:quip, votes: 1)]
    visit '/'
    click_on 'Highest Rated'
    page.all('.quip_display').each_with_index do |div, i|
      page.within(div) do
        page.should have_content "##{quips[i].id}"
      end
    end
  end

  it 'should sort by newest' do
    quips = [FactoryGirl.create(:quip, created_at: 1.day.ago), FactoryGirl.create(:quip, created_at: 1.month.ago), FactoryGirl.create(:quip, created_at: 1.year.ago)]
    visit '/'
    click_on 'Newest'
    page.all('.quip_display').each_with_index do |div, i|
      page.within(div) do
        page.should have_content "##{quips[i].id}"
      end
    end
  end

  it' should sort by oldest' do
    quips = [FactoryGirl.create(:quip, created_at: 1.year.ago), FactoryGirl.create(:quip, created_at: 1.month.ago), FactoryGirl.create(:quip, created_at: 1.day.ago)]
    visit '/'
    click_on 'Oldest'
    page.all('.quip_display').each_with_index do |div, i|
      page.within(div) do
        page.should have_content "##{quips[i].id}"
      end
    end
  end
end



