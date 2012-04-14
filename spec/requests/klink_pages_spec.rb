require 'spec_helper'

describe "Klink pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "klink creation" do
    before { visit root_path }

    # TODO adaptar e colocar em funcionamento quando se usar fotos
    # describe "with invalid information" do

    #   it "should not create a klink" do
    #     expect { click_button "klink!" }.should_not change(Klink, :count)
    #   end

    #   describe "error messages" do
    #     before { click_button "klink!" }
    #     it { should have_content('error') } 
    #   end
    # end

    # describe "with valid information" do

    #   before { fill_in 'klink_description', with: "example" }
    #   it "should create a klink" do
    #     expect { click_button "klink!" }.should change(Klink, :count).by(1)
    #   end
    # end

    describe "klink destruction" do
      before { FactoryGirl.create(:klink, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a klink" do
          expect { click_link "delete" }.should change(Klink, :count).by -1
        end
      end
    end
  end
end
