require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "klinkr" }

  describe "Home page" do

    it "should have the h1 'klinkr'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'klinkr')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "#{base_title}")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => ' | ')
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        :text => "#{base_title} | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About klinkr'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About klinkr')
    end

    it "should have the title 'About klinkr'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    :text => "#{base_title} | About klinkr")
    end
  end
end