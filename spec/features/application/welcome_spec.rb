require 'rails_helper'

RSpec.describe 'root welcome page' do
  context 'you go to the main page' do
    it 'has collaborators and their commits in the footer' do
      visit root_path

      expect(page).to have_content('BrianZanti - 39 commits')
    end
  end
end