ActiveAdmin.register Category do
  menu label: 'Categorías'
  remove_filter :gift_categorizations
  filter :name, label: 'Nombre'
  filter :created_at, label: 'Fecha de creación'
  filter :updated_at, label: 'Última actualización'
  permit_params :name

  show do
    attributes_table do
      row 'Nombre', &:name
      row 'Fecha de creación', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column 'Nombre', :name
    column 'Fecha de creación', :created_at
    column 'Última actualización', :updated_at

    actions
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name, label: 'Nombre'
    end
    f.actions
  end
end
