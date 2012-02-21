class Admin::HomeController < Admin::ApplicationController

  def index
    #generate the animal percentages for the dashboard
    @animals_count = Animal.count(:conditions => {:organization_id => current_user.organization_id}) 
    @animal_update = Animal.order("updated_at desc").first(:conditions => {:organization_id => current_user.organization_id}).try(:updated_at)
    @final_status_hash = Rails.cache.fetch("animal_status_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by_status(current_user.organization_id)
    end
    #@final_status_hash = Report.animals_by_status(current_user.organization.id)
    @final_species_hash = Rails.cache.fetch("animal_species_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by_species(current_user.organization_id)
    end
  end
  
end