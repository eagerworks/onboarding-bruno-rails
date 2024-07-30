ActiveAdmin.register Gift do
  permit_params :name, :price, :valoration, :supplier_id, :image, :content, category_ids: [],
                                                                            customization_ids: []

  remove_filter :gift_customizations, :gift_categorizations, :purchases,
                :image_attachment, :image_blob, :rich_text_content

  filter :name
  filter :price
  filter :valoration
  filter :supplier
  filter :categories, multiple: true
  filter :customizations, multiple: true
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.includes(:supplier)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :valoration
    column :supplier
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :valoration
      row :supplier
      row 'Imagen' do |gift|
        image_tag gift.image_resized_for_purchase
      end
      row 'Contenido' do |gift|
        gift.content.to_s
      end
      row 'Categorías' do |gift|
        dropdown_menu '' do
          gift.categories.each do |category|
            item category.name
          end
        end
      end
      row 'Personalizaciones' do |gift|
        dropdown_menu '' do
          gift.customizations.each do |customization|
            item customization.name, admin_customization_path(customization)
          end
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name
      f.input :price
      f.input :valoration
      f.input :supplier
      f.input :image, as: :file
      f.input :content
      f.input :categories
      f.input :customizations
    end
    f.actions
  end
end
