ActiveAdmin.register Supplier do
  remove_filter :gifts
  filter :name
  filter :created_at
  filter :updated_at
  permit_params :name

  controller do
    def scoped_collection
      super.includes(:gifts)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column 'Regalos' do |supplier|
      dropdown_menu '' do
        supplier.gifts.each do |gift|
          item gift.name, admin_gift_path(gift)
        end
      end
    end
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

  show do
    attributes_table do
      row :name
      row 'Regalos' do |supplier|
        dropdown_menu '' do
          supplier.gifts.each do |gift|
            item gift.name, admin_gift_path(gift)
          end
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
