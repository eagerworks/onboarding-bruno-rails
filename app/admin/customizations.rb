ActiveAdmin.register Customization do
  permit_params :name, :price
  menu label: 'Personalizaciones'
  filter :name, label: 'Nombre'
  filter :price, label: 'Precio'

  index do
    selectable_column
    id_column
    column 'Nombre', :name
    column 'Precio', :price
    column 'Fecha de creación', :created_at
    column 'Última actualización', :updated_at
    actions
  end

  show do
    attributes_table do
      row 'Nombre', &:name
      row 'Precio', &:price
      row 'Fecha de creación', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name, label: 'Nombre'
      f.input :price, label: 'Precio'
    end
    f.actions
  end
end
