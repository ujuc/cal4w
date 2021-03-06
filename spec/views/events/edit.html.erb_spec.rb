# frozen_string_literal: false
require "rails_helper"

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, create(:event))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select 'input#event_subject[name=?]', "event[subject]"

      assert_select 'input#event_place[name=?]', "event[place]"

      assert_select 'textarea#event_description[name=?]', "event[description]"
    end
  end
end
