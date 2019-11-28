Then("I should see the following times for {string}:") do |name, table|
    user = User.where(name: name)[0]
    table.rows.each do |day, time|
        table_id = "#"+day+'-'+time+'-'+user.id.to_s
        not_selected = page.find(table_id)[:class].include?("not-selected")
        expect(not_selected).to be(false)
    end
end