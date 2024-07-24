ActiveAdmin.register Purchase do
  permit_params :RUT, :social_reason, :suprise_delivery,
                :personalization, :resend_delivery, :amount, :company_logo,
                :gift_id,
                :payment_method_id,
                customization_ids: [],
                destinations_attributes: %i[id receiver day address number cost schedules _destroy]

  menu label: 'Compras'

  controller do
    def scoped_collection
      super.includes(:user, :gift, :customizations)
    end
  end

  remove_filter :payment_method, :destinations, :subtotal, :personalization
  filter :gift, label: 'Regalo'
  filter :user, label: 'Usuario', as: :select, collection: User.all.map { |user|
                                                             [user.email, user.id]
                                                           }
  filter :price, label: 'Precio'
  filter :amount, label: 'Cantidad'
  filter :suprise_delivery, label: 'Entrega Sorpresa'
  filter :resend_delivery, label: 'Reenvío Disponible'
  filter :created_at, label: 'Fecha de creación'
  filter :updated_at, label: 'Última actualización'

  index do
    selectable_column
    id_column
    column 'Precio', :price
    column 'Cantidad', :amount
    column 'Entrega Sorpresa', :suprise_delivery
    column 'Reenvío Disponible', :resend_delivery
    column 'Regalo', :gift
    column 'Usuario' do |purchase|
      link_to purchase.user_email, admin_user_path(purchase.user)
    end
    column 'Fecha de compra', :created_at
    actions
  end

  show do
    attributes_table do
      row 'RUT', &:RUT
      row 'Razón Social', &:social_reason
      row 'Precio', &:price
      row 'Cantidad', &:amount
      row 'Mensaje Personalizado', &:personalization
      row 'Entrega Sorpresa', &:suprise_delivery
      row 'Reenvío Disponible', &:resend_delivery
      row 'Logo' do |purchase|
        image_tag purchase.company_logo if purchase.company_logo.present?
      end
      row 'Regalo', &:gift
      row 'Usuario' do |purchase|
        link_to purchase.user_email, admin_user_path(purchase.user)
      end
      row 'Fecha de compra', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles de la Compra' do
      f.input :RUT, label: 'RUT'
      f.input :social_reason, label: 'Razón Social'
      f.input :amount, label: 'Cantidad'
      f.input :personalization, label: 'Mensaje Personalizado'
      f.input :suprise_delivery, label: 'Entrega Sorpresa'
      f.input :resend_delivery, label: 'Reenvío Disponible'
      f.input :gift, label: 'Regalo' if f.object.new_record?

      unless f.object.new_record?
        f.input :customizations, label: 'Agregados', as: :select,
                                 collection: Customization.joins(:gift_customizations)
                                                          .where(gift_customizations: { gift_id:
                                                          f.object.gift_id })
      end
      f.input :company_logo, label: 'Logo', as: :file
      f.input :payment_method, label: 'Método de Pago', as: :select,
                               collection: PaymentMethod.all.order('user_id').map { |pm|
                                             ["#{pm.name} (#{pm.user.email})", pm.id]
                                           }
      f.inputs 'Destinatarios' do
        f.has_many :destinations, allow_destroy: true, heading: false do |destination|
          destination.input :receiver, label: 'Receptor'
          destination.input :day, label: 'Día', as: :date_picker
          destination.input :address, label: 'Dirección'
          destination.input :number, label: 'Número'
          destination.input :cost, label: 'Costo'
          destination.input :schedules, label: 'Horarios'
        end
      end
    end
    f.actions
  end
end
