ActiveAdmin.register Gift do
  permit_params :name, :price, :valoration, :supplier_id, :image, :content, category_ids: [],
                                                                            customization_ids: []

  menu label: 'Regalos'
  remove_filter :gift_customizations, :gift_categorizations, :purchases,
                :image_attachment, :image_blob, :rich_text_content

  filter :name, label: 'Nombre'
  filter :price, label: 'Precio'
  filter :valoration, label: 'Valoración'
  filter :supplier, label: 'Proveedor'
  filter :categories, label: 'Categorías', multiple: true
  filter :customizations, label: 'Personalizaciones', multiple: true
  filter :created_at, label: 'Fecha de creación'
  filter :updated_at, label: 'Última actualización'

  controller do
    def scoped_collection
      super.includes(:supplier)
    end
  end

  index do
    selectable_column
    id_column
    column 'Nombre', :name
    column 'Precio', :price
    column 'Valoración', :valoration
    column 'Proveedor', :supplier
    column 'Fecha de creación', :created_at
    column 'Última actualización', :updated_at
    actions
  end

  show do
    attributes_table do
      row 'Nombre', &:name
      row 'Precio', &:price
      row 'Valoración', &:valoration
      row 'Proveedor', &:supplier
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
      row 'Fecha de creación', &:created_at
      row 'Última actualización', &:updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Detalles' do
      f.input :name, label: 'Nombre'
      f.input :price, label: 'Precio'
      f.input :valoration, label: 'Valoración'
      f.input :supplier, label: 'Proveedor'
      f.input :image, label: 'Imagen', as: :file
      f.input :content, label: 'Contenido'
      f.input :categories, label: 'Categorías'
      f.input :customizations, label: 'Personalizaciones'
    end
    f.actions
  end
end
