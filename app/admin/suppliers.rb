ActiveAdmin.register Supplier do
  menu label: 'Proveedores'
  remove_filter :gifts
  filter :name, label: 'Nombre'
  filter :created_at, label: 'Fecha de creación'
  filter :updated_at, label: 'Última actualización'
  permit_params :name

  controller do
    def scoped_collection
      super.includes(:gifts)
    end
  end

  index do
    selectable_column
    id_column
    column 'Nombre', :name
    column 'Regalos' do |supplier|
      dropdown_menu '' do
        supplier.gifts.each do |gift|
          item gift.name, admin_gift_path(gift)
        end
      end
    end
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

  show do
    attributes_table do
      row 'Nombre', &:name
      row 'Regalos' do |supplier|
        dropdown_menu '' do
          supplier.gifts.each do |gift|
            item gift.name, admin_gift_path(gift)
          end
        end
      end
      row 'Fecha de creación', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end
end
