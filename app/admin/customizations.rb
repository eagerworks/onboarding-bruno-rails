ActiveAdmin.register Customization do
  permit_params :name, :price
  filter :name
  filter :price

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name
      f.input :price
    end
    f.actions
  end
end
