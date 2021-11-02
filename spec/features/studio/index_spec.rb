require 'rails_helper'

RSpec.describe 'studio index page' do
  before do
    @studio1 = Studio.create!(name: "Syntax Studios", location: "Burbank")
    @movie1 = @studio1.movies.create!(title: "Active Record", creation_year: 2022, genre: "Suspense/Thriller")
    @movie2 = @studio1.movies.create!(title: "Add Foreign Key", creation_year: 2022, genre: "Romantic/Comedy")
    @actor1 = Actor.create!(name: "Ruby Rails", age: 27)
    @actor2 = Actor.create!(name: "Mercy Quill", age: 53)
    @actor3 = Actor.create!(name: "Repo Pomodoro", age: 33)
    @movie_actor = MovieActor.create!(movie_id: @movie1.id, actor_id:@actor1.id)
    @movie_actor = MovieActor.create!(movie_id: @movie1.id, actor_id:@actor2.id)
    @movie_actor = MovieActor.create!(movie_id: @movie2.id, actor_id:@actor1.id)
    @movie_actor = MovieActor.create!(movie_id: @movie2.id, actor_id:@actor3.id)
    visit studio_path
  end

  it "i see each studio's name and location" do
    within "#studio-#{@studio1.id}" do
      expect(page).to have_content(@studio.name)
      expect(page).to have_content(@studio.location)
    end
  end

  it "underneath each studio, i see the titles of all it's movies" do
    within "#studio-#{@studio1.id}" do
      expect(page).to have_content([@movie1, @movie2])
    end
  end
end 