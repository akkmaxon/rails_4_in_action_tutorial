require 'rails_helper'

RSpec.feature "User can view projects" do
  scenario "with the project details" do
    project = FactoryGirl.create(:project, name: "Vim editor")

    visit "/"
    click_link "Vim editor"
    expect(page.current_url).to eq project_url(project)
  end
end
