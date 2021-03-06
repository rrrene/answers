ActiveAdmin.register Category do
  controller.authorize_resource

  index do
    column :name, :sortable => :name
    column "Created", :created_at
    column "Updated", :updated_at
    column "Description", :description
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end

  show do

    attributes_table do
      row :name
      row :description
    end

    div do
      panel("Articles with this category") do

        table_for(category.articles) do
          column "" do |article|
            if article.is_a? QuickAnswer
              link_to( "Edit", edit_admin_quick_answer_path(article))
            elsif article.is_a? WebService
              link_to( "Edit", edit_admin_web_service_path(article) )
            elsif article.is_a? Guide
              link_to( "Edit", admin_guide_path(article))
            end
          end
          column "" do |article|
            if article.status=="Published"
              link_to "View", article
            else
              "Draft"
            end
          end

          column :title
          column :type
          column :contact
          column :user
          column :status
        end
      end
    end
  end
end
