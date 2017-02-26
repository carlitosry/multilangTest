poll = {
  ul: '.row-customers',
  deleteCustomerButton: '.delete-row-item',
  deleteCustomerConfirmationModal: '#customer-delete-confirmation',
  deleteCustomerConfirmationModalButton: '.delete-customer-row-item',

  deleteCustomerHandler: () ->
    self = @;

    $(self.ul).on('click',self.deleteCustomerButton, (ev) ->
      element = ev.target;
      li = $(element).parents('li');

      $(self.deleteCustomerConfirmationModal).modal('toggle').on('click',self.deleteCustomerConfirmationModalButton, () ->
        li.remove();
        $(self.deleteCustomerConfirmationModal).modal('hide');
      );
    );

  init: () ->
    @deleteCustomerHandler();
};

poll.init();

