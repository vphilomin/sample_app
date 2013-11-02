require 'spec_helper'

describe "MicropostPages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
  	before { visit root_path }

  	describe "with invalid information" do
  		
  		it "should not create a micropost" do
  			expect { click_button "Post" }.not_to change(Micropost, :count).by(1)
  		end

  		describe "error messages" do
  			before { click_button "Post" }
  			it { should have_content('error') }
  		end
  	end

  	describe "with valid information" do
  		before { fill_in 'micropost_content', with: "Lorem ipsum" }

  		it "should create a micropost" do
  			expect { click_button "Post" }.to change(Micropost, :count).by(1)
  		end
  	end
  end

  describe "micropost destruction" do
  	before { FactoryGirl.create(:micropost, user: user) }

  	describe "as correct user" do
  		before { visit root_path }

  		it "should delete a micropost" do
			expect{ click_link "delete" }.to change(Micropost, :count).by(-1)  			
  		end
  	end
  end

  describe "micropost sidebar" do
	before { FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum") }

  	describe "when micropost count is one" do
  		before { visit root_path }

		it "should render the user's micropost count in singular" do
			expect(page).to have_content("#{user.microposts.count} micropost")
		end
  	end

  	describe "when micropost count is more than one" do
  		before do
  			FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
  			visit root_path
  		end
  		
  		it "should render the user's micropost count in plural" do
  			expect(page).to have_content("#{user.microposts.count} microposts")
  		end
  	end
  end

  describe "pagination" do
	before do
		35.times { FactoryGirl.create(:micropost, user: user) }
		visit root_path
	end
  	after { Micropost.delete_all }

  	it { should have_selector('div.pagination') }

  	it "should list each micropost in feed" do
  		Micropost.paginate(page: 1).each do |micropost|
  			expect(page).to have_selector("li##{micropost.id}", text: micropost.content)					
  		end
  	end
  end

  describe "delete links for microposts" do
  	let(:another_user) { FactoryGirl.create(:user) }

  	describe "of another user" do
	  	before do
	  		5.times { FactoryGirl.create(:micropost, user: another_user) }
	  		visit user_path(another_user)
	  	end
  		
		it { should_not have_link('delete') }
  	end

	describe "of current user" do
	  	before do
	  		5.times { FactoryGirl.create(:micropost, user: user) }
	  		visit user_path(user)
	  	end
  		
		it { should have_link('delete') }		
	end
  end
end
