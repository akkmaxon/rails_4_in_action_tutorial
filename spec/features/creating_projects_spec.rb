require 'rails_helper'

RSpec.feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"
    click_link "New Project"

    fill_in "Name", with: "Vim editor"
    fill_in "Description", with: "A text editor for best developers"
    click_button "Create Project"

    expect(page).to have_content "Project has been created"
    project = Project.find_by(name: "Vim editor")
    expect(page.current_url).to eq project_url(project)
    title = "Vim editor - Projects - Ticketee"
    expect(page).to have_title title
  end
end
