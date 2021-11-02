require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  before do
    @studio1 = Studio.create!(name: "Syntax Studios", location: "Burbank")
    @movie1 = @studio1.movies.create!(title: "Active Record", creation_year: 2022, genre: "Suspense/Thriller")
    # @movie2 = @studio1.movies.create!(title: "Add Foreign Key", creation_year: 2022, genre: "Romantic/Comedy")
    @actor1 = Actor.create!(name: "Ruby Rails", age: 27)
    @actor2 = Actor.create!(name: "Mercy Quill", age: 53)
    @actor3 = Actor.create!(name: "Repo Pomodoro", age: 33)
    @movie_actor = MovieActor.create!(movie_id: @movie1.id, actor_id:@actor1.id)
    @movie_actor = MovieActor.create!(movie_id: @movie1.id, actor_id:@actor2.id)
    # @movie_actor = MovieActor.create!(movie_id: @movie2.id, actor_id:@actor1.id)
    # @movie_actor = MovieActor.create!(movie_id: @movie2.id, actor_id:@actor3.id)
    visit movie_path
  end

  it 'shows movie title, creation year, and genre' do
    expect(page).to have_content(@movie1.title)
    expect(page).to have_content(@movie1.creation_year)
    expect(page).to have_content(@movie1.genre)
  end

  it 'lists all actors from younest to oldest' do
    expect(@actor1).to appear_before(@actor2)
  end

  it 'i see the average age of all of the movies actors' do
    expect(page).to have_content("Average Actor Age: #{@actors.average_age}")
  end

  describe 'add an actor to a movie' do
    it 'i do not see any actor listed that are not part of the movie' do
      expect(page).to_not have_content(@actor3)
    end

    it 'i see a form to add an actor to this movie' do
      expect(page).to have_content("Add an Actor:")
    end

    it 'when i fill out the form and click submit, i am redirected to movie show page and see the actor added' do
      fill_in "Name", with: "Alan Turing"
      fill_in "Age", with: 55
      click_on "Submit"
      expect(current_path).to eq("/movies/#{@movie1.id}")
      expect(page).to have_content("Alan Turing")
    end
  end
end