ActiveAdmin.register User do
  permit_params :name, :last_name, :email, :company_name, :password,
                payment_methods_attributes: %i[id name owner card_number due_date CVV _destroy]
  menu label: 'Usuarios'
  filter :name, label: 'Nombre'
  filter :last_name, label: 'Apellido'
  filter :email, label: 'Email'
  filter :company_name, label: 'Empresa'
  filter :created_at, label: 'Fecha de creación'
  filter :updated_at, label: 'Última actualización'

  controller do
    def scoped_collection
      super.includes(:payment_methods)
    end
  end

  index do
    selectable_column
    id_column
    column 'Nombre', :name
    column 'Apellido', :last_name
    column 'Email', :email
    column 'Empresa', :company_name
    column 'Métodos de Pago' do |user|
      dropdown_menu '' do
        user.payment_methods.each do |payment_method|
          item payment_method.name
        end
      end
    end
    column 'Fecha de creación', :created_at
    column 'Última actualización', :updated_at
    actions
  end

  show do
    attributes_table do
      row 'Nombre', &:name
      row 'Apellido', &:last_name
      row 'Email', &:email
      row 'Empresa', &:company_name
      row 'Métodos de Pago' do |user|
        dropdown_menu '' do
          user.payment_methods.each do |payment_method|
            item payment_method.name
          end
        end
      end
      row 'Fecha de creación', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles del Usuario' do
      f.input :name, label: 'Nombre'
      f.input :last_name, label: 'Apellido'
      f.inputs 'Métodos de Pago' do
        f.has_many :payment_methods,
                   allow_destroy: true, heading: false do |payment_method|
          payment_method.input :name, label: 'Nombre'
          payment_method.input :owner, label: 'Titular'
          payment_method.input :card_number, label: 'Número de Tarjeta'
          payment_method.input :due_date, label: 'Fecha de Vencimiento', as: :date_picker
          payment_method.input :CVV, label: 'CVV'
        end
      end
      f.input :email, label: 'Email'
      f.input :company_name, label: 'Empresa'
      f.input :password, label: 'Contraseña' if f.object.new_record?
    end
    f.actions
  end
end
