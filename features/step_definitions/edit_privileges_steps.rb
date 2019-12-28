Then /^I should see the checkboxes:$/ do |checks|
	checks.hashes.each do |box|
		user = User.where(name: box[:name])[0]
		if box[:auth_checked] == "true"
			expect(find("#auth-#{user.id}")).to be_checked
		end
		if box[:admin_checked] == "true"
			expect(find("#admin-#{user.id}")).to be_checked
		end
	end
end

When /^I u?n?check (\w*)'s (auth|admin)$/ do |name, type|
	user = User.where(name: name)[0]
	find("##{type}-#{user.id}").click
end

When /^I follow (\w+)'s "Update User"$/ do |name|
	user = User.where(name: name)[0]
	steps %{When I press "#submit-#{user.id}"}
end

Then /^I should not be able to u?n?check (\w+)'s (auth|admin)$/ do |name, type|
	user = User.where(name: name)[0]
	inp = find("##{type}-#{user.id}")
	is_checked = inp.checked?
	inp.click
	expect(inp.checked?).to eq(is_checked)
end

Then /^(\w+) should be an? (auth|admin)$/ do |name, type|
	user = User.where(name: name)[0]
	expect(user.send type.to_sym).to eq(true)
end

Then /^I should be redirected to "(.*)"$/ do |page|
	expect(URI.parse(current_url).path).to eq(page)
end
