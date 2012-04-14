require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "klinkr" }
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector 'h1', text: heading }
    it { should have_selector 'title', text: full_title(page_title) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About klinkr')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'klinkr' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:klink, user: user, description: "First")
        FactoryGirl.create(:klink, user: user, description: "Second")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.description)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About klinkr' }
    let(:page_title) { 'About klinkr' }

    it_should_behave_like "all static pages"
  end
end