ActiveAdmin.register Category do
  remove_filter :gift_categorizations
  filter :name
  filter :created_at
  filter :updated_at
  permit_params :name

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name
    end
    f.actions
  end
end