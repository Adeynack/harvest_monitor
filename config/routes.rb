# frozen_string_literal: true

Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path
  root "monitor#show"
end
