module Comable
  class OrderMailer < ActionMailer::Base
    helper Comable::ApplicationHelper
    helper_method :subject_for

    def complete(order)
      @order = order
      mail(from: current_store.email_sender, to: order.email, subject: subject_for(order))
    end

    private

    def current_store
      Comable::Store.instance
    end

    def subject_for(order)
      [
        current_store.name,
        I18n.t('comable.order_mailer.complete.subject'),
        order.code
      ].join(' ')
    end
  end
end