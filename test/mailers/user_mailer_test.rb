require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

	def setup
		@user                = users(:Starman)
		@user.remember_token = User.new_token
	end

	test "account_activation" do
		mail = UserMailer.account_activation(@user)
		assert_equal "Account activation", mail.subject
		assert_equal [@user.email], mail.to
		assert_equal ["noreply@example.com"], mail.from
		assert_match @user.name, mail.body.encoded
		assert_match @user.remember_token, mail.body.encoded
		assert_match CGI.escape(@user.email), mail.body.encoded
	end

	test "password_reset" do
		mail = UserMailer.password_reset
		assert_equal "Password reset", mail.subject
		assert_equal ["to@example.org"], mail.to
		assert_equal ["noreply@example.com"], mail.from
		assert_match "Hi", mail.body.encoded
	end

end
