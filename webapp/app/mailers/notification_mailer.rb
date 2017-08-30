class NotificationMailer < ApplicationMailer
    default to: Rails.configuration.admin_mails

    def ownership_request_notification(request)
        @request = request
        @user = request.user
        @page = request.page
        msg = "New Ownership Request from #{@user.name} of #{@page.name}"
        mail(subject: msg, body: msg)
    end

    def new_user_notification(user)
        @user = user
        msg = "New registered user: #{@user.name}"
        mail(subject: msg, body: msg)
    end

    def page_edit_notification(user, page)
        @user = user
        @page = page
        msg = "Page #{@page.name} edited by #{@user.name}"
        mail(subject: msg, body: msg)
    end

end
