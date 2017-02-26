custom = {
  deleteButtonClass: '.delete-submit',
  confirmBox: '#confirm',
  confirmDeleteButton: '#confirmDeleteButton',
  multiselectClass: '.multiselect',
  datetimePickerClass: '.datetime-picker',
  editForm: '.edit-form',
  editSubmit: '.edit-submit',
  carouselContainer: '.carousel-container',
  singleCarouselContainer: '.single-carousel-container',

  deleteConfirmHandler: () ->
    self = @;

    $('button' + self.deleteButtonClass).on('click', (e) ->

      $form=$(@).closest('form');
      e.preventDefault();

      $(self.confirmBox).modal({ backdrop: 'static', keyboard: false })
      .one('click', '#cofirmDeleteButton',  (e) ->
        $form.trigger('submit');
      );

    );
    return;

  multiSelectHandler: () ->
    self = @;

    $(self.multiselectClass).multiSelect();

    return;

  datetimePickerHandler: ()->
    self = @;

    $(self.datetimePickerClass).datetimepicker({
      sideBySide: true,
      minDate: moment().hour(0).minute(0).seconds(0),
      keepInvalid: true,
      showTodayButton: true,
      showClear: true,
      format: 'DD/MM/YYYY H:mm',
    });

    return;

  editFormSubmit: ()->
    self = @;

    $(self.editSubmit).on('click',()->
      $(self.editForm).submit();
    );

    return;

  carouselHandler: () ->
    self = @;

    $(self.carouselContainer).each(()->
      items = $(@).data('items');
      $(@).owlCarousel({
        navigation : true, # Show next and prev buttons
        slideSpeed : 300,
        items : items,
        paginationSpeed : 400
      });
    );

    return;

  singleCarouselHandler: () ->
    self = @;

    $(self.singleCarouselContainer).each(()->
      $(@).owlCarousel({
        navigation : false, # Show next and prev buttons
        slideSpeed : 300,
        paginationSpeed : 400,
        singleItem:true
      });
    );

    return;

  init: ()->
    @deleteConfirmHandler();
#    @multiSelectHandler();
#    @datetimePickerHandler();
    @editFormSubmit();
#    @carouselHandler();
#    @singleCarouselHandler();
};

custom.init();