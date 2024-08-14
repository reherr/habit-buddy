class MetaTagService
  def self.defaults
    {
      site: 'HabitBuddy',
      image: ActionController::Base.helpers.asset_url('cuterhippo-chatbubble.png'),
      description: 'Start your life-changing journey.',
      og: {
        title: 'HabitBuddy',
        image: ActionController::Base.helpers.asset_url('cuterhippo-chatbubble.png'),
        description: 'Start your life-changing journey.',
        site_name: 'HabitBuddy'
      }
    }
  end
end
