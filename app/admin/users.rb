ActiveAdmin.register User do
  permit_params :name, :last_name, :email, :company_name, :password,
                payment_methods_attributes: %i[id name owner card_number due_date CVV _destroy]

  filter :name
  filter :last_name
  filter :email
  filter :company_name
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.includes(:payment_methods)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :last_name
    column :email
    column :company_name
    column 'Métodos de Pago' do |user|
      dropdown_menu '' do
        user.payment_methods.each do |payment_method|
          item payment_method.name
        end
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :last_name
      row :email
      row :company_name
      row 'Métodos de Pago' do |user|
        dropdown_menu '' do
          user.payment_methods.each do |payment_method|
            item payment_method.name
          end
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles del Usuario' do
      f.input :name
      f.input :last_name
      f.inputs 'Métodos de Pago' do
        f.has_many :payment_methods,
                   allow_destroy: true, heading: false do |payment_method|
          payment_method.input :name
          payment_method.input :owner
          payment_method.input :card_number
          payment_method.input :due_date, as: :date_picker
          payment_method.input :CVV
        end
      end
      f.input :email
      f.input :company_name
      f.input :password if f.object.new_record?
    end
    f.actions
  end
end
