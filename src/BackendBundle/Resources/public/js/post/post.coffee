postResource = {
  textEditorInputClass: '.text-editor',
  addNewItemButton: '.add-new-item',
  fakeAddNewItemButton: '.add-media-to-post',
  postMediaContainer: '.post-media',
  postMediaItem: '.gallery-media-item',
  galleryItemChoice: '.gallery-item-file-type',
  galleryItemUrl: '.gallery-item-url',
  galleryItemFile: '.gallery-item-image-file',
  ul: '.row-customers',
  deleteCustomerButton: '.delete-row-item',
  deleteCustomerConfirmationModal: '#customer-delete-confirmation',
  deleteCustomerConfirmationModalButton: '.delete-customer-row-item',
  prominentImageButton: '.prominent-image-button',
  prominentImageField: '.prominent-image-field',
  newProminentImage: '.new-prominent-image',
  editForm: '.edit-form',
  editSubmitButton: '.edit-submit',

  textEditorHandler: ()->
    self = @;

    $(self.textEditorInputClass).wysihtml5({
      "image": false,
      toolbar: {
        "font-styles": true, #Font styling, e.g. h1, h2, etc. Default true
        "emphasis": true, #Italics, bold, etc. Default true
        "lists": true, #(Un)ordered lists, e.g. Bullets, Numbers. Default true
        "html": false, #Button which allows you to edit the generated HTML. Default false
        "link": true, #Button to insert a link. Default true
        "image": false, #Button to insert an image. Default true,
        "color": false, #Button to change color of font
        "blockquote": true, #Blockquote
        "size": '<buttonsize>' #default: none, other options are xs, sm, lg
      }
    });

    return;

  fakeAddItemHandling: ()->
    self = @;

    $(self.fakeAddNewItemButton).on('click',(ev)->
      ev.preventDefault();
      $(self.postMediaContainer).find(self.addNewItemButton).trigger('click');
    );

    return;

  ulOnRowInserted: () ->
    self = @;

    $(self.ul).on('row-inserted',()->
      $(self.ul).find(self.galleryItemChoice).each(()->
        $(@).off('change')
        $(@).on('change',()->
          element = $(@)
          selected = element.val();
          if(selected != '')
            if(selected == 'Video')
              element.parents('.caption').find(self.galleryItemUrl).removeClass('hide');
              element.parents('.caption').find(self.galleryItemFile).addClass('hide');
            else
              element.parents('.caption').find(self.galleryItemUrl).addClass('hide');
              element.parents('.caption').find(self.galleryItemFile).removeClass('hide');
        );
      );
    );

    return;

  triggerChange: ()->
    self = @;

    $(self.ul).trigger('row-inserted');

    return $(self.galleryItemChoice).each(()->
      $(@).trigger('change');
    );

  deleteCustomerHandler: () ->
    self = @;

    $(self.ul).on('click',self.deleteCustomerButton, (ev) ->
      element = ev.target;
      li = $(element).parents('li');

      $(self.deleteCustomerConfirmationModal).modal('toggle').on('click',self.deleteCustomerConfirmationModalButton, () ->
        li.remove();
        $(self.deleteCustomerConfirmationModal).modal('hide');
#        $(self.ul).trigger('row-inserted');
      );

    );

  #Function to trigger profile hidden input field
  imageClickTrigger: () ->
    self = @;

    $(self.prominentImageButton).click(()->
      $(self.prominentImageField).trigger('click');
    );

    return;

  profileImagePreview: () ->
    self = @;

    $(self.prominentImageField).on('change',(ev)->
      file = ev.target.files[0];
      reader = new FileReader();
      reader.onload = (e) ->
        $(self.newProminentImage).attr('src', e.target.result);
        return;
      reader.readAsDataURL(file);

    );

    return;

  editFormSubmit: ()->
    self = @;

    $(self.editSubmitButton).on('click',()->
      console.log "XD"
      $(self.editForm).submit();
    );

  init: ()->
    @textEditorHandler();
    @editFormSubmit();
#    @fakeAddItemHandling();
#    @ulOnRowInserted();
#    @triggerChange();
    @deleteCustomerHandler();
#    @imageClickTrigger();
#    @profileImagePreview();
};

postResource.init();