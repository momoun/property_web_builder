Pwb::Engine.routes.draw do
  root to: 'welcome#index'
  resources :welcome, only: :index

  # TODO - get locales dynamically
  scope "(:locale)", locale: /en|nl|es|fr|de|pt|it|ca|ar/ do
    resources :welcome, only: :index

    get "/properties/for-rent/:id/:url_friendly_title" => "props#show_for_rent", as: "prop_show_for_rent"
    get "/properties/for-sale/:id/:url_friendly_title" => "props#show_for_sale", as: "prop_show_for_sale"
  end

  namespace :api do
    namespace :v1 do
      get "/client_translations/:locale" => "client_translations#index"


      # below gets FieldConfig values for a batch_key such as "person-titles"
      # and returns all the locale translations so an admin
      # can manage them..
      get "/lang/admin_translations/:batch_key" => "client_translations#get_by_batch"
      # post "/lang/admin_translations" => "client_translations#create_translation_value"

      # post "/lang/admin_translations/add_locale_translation" => "client_translations#add_locale_translation"
      # delete "/lang/admin_translations/:id" => "client_translations#delete_translation_values"


      get "/agency" => "agency#show"
      get "/infos" => "agency#infos"
      # get "/web-contents" => "agency#infos"
      jsonapi_resources :lite_properties
      jsonapi_resources :properties
      jsonapi_resources :web_contents
      get "/select_values" => "select_values#by_field_names"

      # get "/lite-properties" => "lite_props#index"
    end
  end

end