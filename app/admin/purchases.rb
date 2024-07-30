ActiveAdmin.register Purchase do
  permit_params :RUT, :social_reason, :suprise_delivery,
                :personalization, :resend_delivery, :amount, :company_logo,
                :gift_id,
                :payment_method_id,
                customization_ids: [],
                destinations_attributes: %i[id receiver day address number cost schedules _destroy]

  controller do
    def scoped_collection
      super.includes(:user, :gift, :customizations)
    end
  end

  remove_filter :payment_method, :destinations, :subtotal, :personalization
  filter :gift
  filter :user, as: :select, collection: User.all.map { |user|
                                           [user.email, user.id]
                                         }
  filter :price
  filter :amount
  filter :suprise_delivery
  filter :resend_delivery
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :price
    column :amount
    column :suprise_delivery
    column :resend_delivery
    column :gift
    column 'Usuario' do |purchase|
      link_to purchase.user_email, admin_user_path(purchase.user)
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :RUT
      row :social_reason
      row :price
      row :amount
      row :personalization
      row :suprise_delivery
      row :resend_delivery
      row 'Logo' do |purchase|
        image_tag purchase.company_logo if purchase.company_logo.present?
      end
      row :gift
      row 'Usuario' do |purchase|
        link_to purchase.user_email, admin_user_path(purchase.user)
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles de la Compra' do
      f.input :RUT
      f.input :social_reason
      f.input :amount
      f.input :personalization
      f.input :suprise_delivery
      f.input :resend_delivery
      f.input :gift if f.object.new_record?

      unless f.object.new_record?
        f.input :customizations, as: :select,
                                 collection: Customization.joins(:gift_customizations)
                                                          .where(gift_customizations: { gift_id:
                                                          f.object.gift_id })
      end
      f.input :company_logo, as: :file
      f.input :payment_method, as: :select,
                               collection: PaymentMethod.all.order('user_id').map { |pm|
                                             ["#{pm.name} (#{pm.user.email})", pm.id]
                                           }
      f.inputs 'Destinatarios' do
        f.has_many :destinations, allow_destroy: true, heading: false do |destination|
          destination.input :receiver
          destination.input :day, as: :date_picker
          destination.input :address
          destination.input :number
          destination.input :cost
          destination.input :schedules
        end
      end
    end
    f.actions
  end
end
