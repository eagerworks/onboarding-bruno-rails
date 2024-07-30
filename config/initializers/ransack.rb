Rails.application.config.to_prepare do
  ActiveStorage::Attachment.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[blob_id created_at id id_value name record_id record_type]
    end
  end

  ActionText::RichText.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[body created_at id id_value name record_id record_type updated_at]
    end
  end

  Supplier.class_eval do
    def self.ransackable_associations(_auth_object = nil)
      ['gifts']
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at id id_value name updated_at]
    end
  end

  Purchase.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[RUT amount created_at gift_id id id_value payment_method_id
         personalization price resend_delivery social_reason subtotal suprise_delivery updated_at]
    end
  end

  Gift.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at id id_value name price supplier_id updated_at valoration]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[categories customizations gift_categorizations gift_customizations
         image_attachment image_blob purchases rich_text_content supplier]
    end
  end

  GiftCustomization.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at customization_id gift_id id id_value updated_at]
    end
  end

  GiftCategorization.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[category_id created_at gift_id id id_value updated_at]
    end
  end
  User.class_eval do
    def self.ransackable_associations(_auth_object = nil)
      ['payment_methods']
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[company_name created_at email id id_value last_name
         name remember_created_at updated_at]
    end
  end

  PaymentMethod.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[CVV card_number created_at due_date id id_value name owner updated_at user_id]
    end
  end

  Customization.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at id id_value name price updated_at]
    end
  end

  Category.class_eval do
    def self.ransackable_associations(_auth_object = nil)
      %w[gift_categorizations gifts]
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at id id_value name updated_at]
    end
  end

  Purchase.class_eval do
    def self.ransackable_associations(_auth_object = nil)
      %w[gift payment_method user]
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[created_at updated_at RUT social_reason price suprise_delivery resend_delivery amount]
    end
  end

  Destination.class_eval do
    def self.ransackable_attributes(_auth_object = nil)
      %w[address cost created_at day id id_value number purchase_id
         receiver schedules updated_at]
    end
  end
end
