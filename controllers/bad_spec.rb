# great example of "build something, then use tests to fossilize it"
# this means writing tests that enclose the tested code in carbonite,
# rather than prove expectations about the code's behavior.
# with the tests below, we will know if the behavior changes, but we
# won't know why or how. reading these tests don't give a good sense of
# how we expect the controller to behave.
describe ThingsController do
  # if this test fails, what was the cause? there's a lot here to parse.
  it "returns all things and attributes except for disabled ones" do
    @things = create(:things)

    get :index, :format => :json
    body = JSON.parse(response.body)
    found_disabled_thing = false
    found_super_disabled_thing = false
    found_disabled_thing_attribute = false

    # three things returned, but no indication of the significance of
    # them. better would be to assign each thing to a
    # descriptively-named variable
    expect(@things.count).to eq 3

    # looping through a collection stuff and making fly-by assertions.
    # this is difficult to troubleshoot when an assertion fails.
    @things.each do |thing|
      # comparing against the second element of the @things array, but
      # no indication why that is
      if thing.enabled? && !thing.name.eql?(@things[1].name)
        thing_json = body.find { |e| e['id'] == thing.id }
        expect(thing_json).not_to be_nil
        thing.attribute_members.each do |am|
          # different expectations based on an "enabled?" method.
          # the person reading this has no clue what this means.
          if am.enabled?
            expect(!!thing_json['attributes'].find { |a| a['id'] == am.id }).to be true
          else
            expect(!!thing_json['attributes'].find { |a| a['id'] == am.id }).to be false
            # overly broad net. how often does this variable get
            # assigned to true? you'd need to step through the code to
            # figure it out.
            found_disabled_thing_attribute = true
          end
        end
      else
        # what does this mean? what are we testing here?
        expect(body.map{|e| e['id']}).to_not include thing.id
        found_disabled_thing = true unless thing.name.eql?(@things[1].name)
        found_super_disabled_thing = true if thing.name.eql?(@things[1].name)
      end
    end

    # piggy-backing assertions. better to have a test explicitly for each of these.
    expect(found_disabled_thing).to be true
    expect(found_super_disabled_thing).to be true
    expect(found_disabled_thing_attribute).to be true
  end

end
