require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it { should use_before_action(:require_logout) }
end
