class Scope
  include Mongoid::Document

  embedded_in :concerns_scopable, :polymorphic => true
end