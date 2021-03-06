class OrganizationSweeper < ActionController::Caching::Sweeper
  observe Organization # This sweeper is going to keep an eye on the Product model
 
  # If our sweeper detects that a Product was created call this
  def after_create(organization)
    expire_cache_for(organization)
  end
 
  # If our sweeper detects that a Product was updated call this
  def after_update(organization)
    expire_cache_for(organization)
  end
 
  # If our sweeper detects that a Product was deleted call this
  def after_destroy(organization)
    expire_cache_for(organization)
  end
 
  private
  def expire_cache_for(animal)
    # Expire the index page now that we added a new product
    #expire_page(:controller => 'animals', :action => 'show')
 
    # Expire a fragment
    expire_fragment('all_available_organizations')
    expire_fragment('organization')
  end
end