MediaHandling = {
  mediaForm: '.media-upload-form',
  mediaButton: '#media-upload-button',
  mediaField: '.media-upload-field',
  postGalleryContainer: '#post-gallery-items-container',
  postGalleryItem: '.gallery-item',
  galleryItemsField: '.gallery-items',

  fieldChangeDetector: () ->
    self = @;

    Dropzone.autoDiscover = false;
    myDropzone = new Dropzone('#media-upload-form');
    myDropzone.on('success', (file,response) ->
      self.imageItemAdder(response['id'],response['path'],response['name']);
    );

    return;

  imageItemAdder: (id, path, imageName) ->
    self = @;

    imageElement = "<div class='col-md-3 item-wrapper'><img src='#{path}' alt='#{imageName}' data-id='#{id}' class='img-thumbnail img-responsive gallery-item'><button type='button' class='btn btn-danger delete-post-gallery-media'>Eliminar</button></div>";

    $(imageElement).appendTo(self.postGalleryContainer);

    self.galleryItemsFieldAdder();

    return;

  galleryItemsFieldAdder: () ->
    self = @;

    result = [];

    $(self.postGalleryContainer).find(self.postGalleryItem).each(()->
      result.push($(@).data('id'));
    );

    $(self.galleryItemsField).val(result.join(','));


    return;

  #Search for existing content
  gallerySearchField: '#buscar-galeria',
  gallerySearchResultContainer: '#existing-gallery',
  gallerySingleItem: '.media-search-item',
  loadMoreButton: '#load-more',

  galleryGetter: ()->
    self = @;

    $(self.gallerySearchField).on('keyup',()->
      page = $(self.gallerySearchResultContainer).data('page');
      term = $(@).val();
      self.galleryServerHandler(1,term);
    );

    return;

  galleryServerHandler: (page,term)->
    self = @;

    url = Routing.generate('backend_media_ajax_search',{'page':page, 'term':term});

    App.ajax.post(
      url,
      term: term,
      page: page,
      (response) ->
        if page == 1
          $(self.gallerySearchResultContainer).html(response);
        else
          $(self.gallerySearchResultContainer).append(response);
        self.loadMoreIfExists();
    );

    return;

  loadMoreMedias: ()->
    self = @;

    $(self.loadMoreButton).on('click',()->
      page = Number($(self.gallerySearchResultContainer).data('page'));
      term = $(self.gallerySearchField).val();

      self.galleryServerHandler(page,term);
    );

    return;

  loadMoreIfExists: ()->
    self = @;

    totalItems = $(self.gallerySearchResultContainer).find('.gallerySingleItem:last-child').data('total');
    currentItems = $(self.gallerySearchResultContainer).find('.gallerySingleItem').length;

    if currentItems >= totalItems
      $(self.loadMoreButton).addClass('hide');
    else
      $(self.loadMoreButton).removeClass('hide');

    return;

  #edit gallery item section
  editGallerySubmitButton: '#edit-gallery-item-send',
  editGalleryDescriptionField: '#gallery-item-edit-description',
  editGalleryImage: '.gallery-item-edit-image',
  editGalleryForm: '#edit-gallery-item-form',

  imageClickEvent: ()->
    self = @;

    $(self.gallerySearchResultContainer).on('click',self.gallerySingleItem, (ev)->
      element = ev.target;
      element = $(element).parents('.media-search-item');
      element.toggleClass('active');
      self.editMediaForm(element);
    );

    return;

  editMediaForm: (element)->
    self = @;

    id    = $(element).data('id');
    img   = $(element).data('url');
    url   = Routing.generate('backend_media_ajax_update',{'id':id});

    $(self.editGalleryImage).attr("src",img);
    $(self.editGalleryForm).attr('action',url);

    return;

  updateFormServerHandler: ()->
    self = @;

    $(self.editGallerySubmitButton).on('click',()->
      description = $(self.editGalleryDescriptionField).val();
      url = $(self.editGalleryForm).attr('action');

      App.ajax.post(
        url,
        tengoelcontrol: description,
        (response) ->
          return true;
      );
    );

  #Add selected images to the post gallery
  addSelectedImagesButton: '#add-selected-images',
  deleteItemButton: '.delete-post-gallery-media',
  deleteConfirmationModal: '#customer-delete-confirmation',
  deleteConfirmationModalButton: '.delete-customer-row-item',

  addSelectedImagesToPostGallery: ()->
    self = @;

    $(self.addSelectedImagesButton).on('click',()->
      $(self.gallerySearchResultContainer).find(self.gallerySingleItem + '.active').each(()->
        name = $(@).data('name');
        id   = $(@).data('id');
        url  = $(@).data('url');
        self.imageItemAdder(id,url,name);
        $(@).removeClass('active');
      );
    );

    return;

  deleteItemHandler: () ->
    self = @;

    $(self.postGalleryContainer).on('click',self.deleteItemButton, (ev) ->
      element = ev.target;
      parent = $(element).parents('.item-wrapper');

      $(self.deleteConfirmationModal).modal('toggle').on('click',self.deleteConfirmationModalButton, () ->
        parent.remove();
        $(self.deleteConfirmationModal).modal('hide');
      );

    );

  init: ()->
    @galleryGetter();
    @galleryItemsFieldAdder();
    @fieldChangeDetector();
    @imageClickEvent();
    @updateFormServerHandler();
    @loadMoreMedias();
    @addSelectedImagesToPostGallery();
    @deleteItemHandler();
};

MediaHandling.init();

