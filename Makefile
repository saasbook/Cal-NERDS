# make tests will run RSpec and Cucumber tests
tests:
	(bundle exec rspec || true) && (bundle exec cucumber features || true)