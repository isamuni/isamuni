class NotificationMailer < ApplicationMailer
    def ownership_request_notification(request)
        @request = request
        @user = request.user
        @page = request.page

        Rails.configuration.admin_mails.each do |admin_mail|
            mail(to: admin_mail, subject: "New Ownership Request from #{@user.name} of #{@page.name}")
        end
    end
end
