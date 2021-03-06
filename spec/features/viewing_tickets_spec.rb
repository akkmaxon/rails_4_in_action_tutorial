require 'rails_helper'

RSpec.feature "Users can view tickets" do
  before do
    author = FactoryGirl.create(:user)
    vim = FactoryGirl.create(:project, name: "Vim editor")
    assign_role!(author, :viewer, vim)
    FactoryGirl.create(:ticket, 
		       project: vim, 
		       author: author,
		       name: "Make it shiny",
		       description: "Gradients! Starbursts! Oh my!")
    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket,
		       project: ie,
		       author: author,
		       name: "Standards compliance",
		       description: "Isn't a joke.")
    login_as(author)
    visit "/"
  end

  scenario "for a given project" do
    click_link "Vim editor"
    expect(page).to have_content "Make it shiny"
    expect(page).not_to have_content "Standards compliance"

    click_link "Make it shiny"
    within("#ticket h2") do
      expect(page).to have_content "Make it shiny"
    end
    expect(page).to have_content "Gradients! Starbursts! Oh my!"
  end

end
