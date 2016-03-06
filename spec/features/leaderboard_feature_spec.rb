require "spec_helper"
feature "visit_homepage", focus:true do
  scenario "I visit the leaderboard page" do
    visit "/leaderboard"

    expect(page).to have_content('Leaderboard')
  end
end
