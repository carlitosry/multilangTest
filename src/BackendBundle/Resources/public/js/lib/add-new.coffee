class AddNewUl
  ul: null
  label: null
  addButton: null
  indexHandler: null
  liClass: ''
  deleteRowClass: 'delete-row-item'
  addRowClass: 'add-new-item'

  constructor: (@ul, indexHandler=null) ->
    @label = @ul.parent().children('label');
    @index = @ul.children('li').length;
    @indexHandler = indexHandler;
    @addButtonsToExistingElements();

  addButtonsToExistingElements : ->
    self = @;
    @ul.children('li').each( ->
      self.createDeleteButton($(@));
    );
    return;

  createAddButton : ->
    @addButton = $('<button>').addClass('btn btn-success ' + @addRowClass)
    .attr('type', 'button').text('Agregar Nuevo')
    .appendTo(@label);
    return;

  createDeleteButton : (li) ->
    @deleteButton = $('<button>').addClass('btn btn-danger ' + @deleteRowClass)
    .attr('type', 'button').text('Eliminar')
    .appendTo(li.find('.row'))
    return;

  getFormTemplate : ->
    return @ul.data('prototype');

  deleteRow : (li) ->
    li.remove();
    return;

  getIndex: ->
    if @indexHandler then @indexHandler() else @index++;

  addRow : ->
    index = @getIndex();
    template =  @getFormTemplate().replace(/__name__/g, index);
    li = $('<li>').addClass( @liClass ).appendTo(@ul).append(template).data('index', index);
    @createDeleteButton(li);
    @ul.trigger('row-inserted');
    return;

  handleAddRow : ->
    self = @;
    @label.on('click', '.'+@addRowClass, ->
      self.addRow();
    )
    return;

  handleDeleteRow : ->
    self = @;
    @ul.on('click', '.'+@deleteRowClass, ->
      self.deleteRow($(@).parents('li'));
    )
    return;


  initialize : ->
    @createAddButton();
    @handleAddRow();
#    @handleDeleteRow();
    @ul.data('AddNew', this);
    return;


AddNew = {
  listSelector : 'ul[data-prototype]'

  initList : ->
    self = @;
    $(self.listSelector).not('.not-init').each( ->
      self.create($(@));
    );
    return;

  create : (elem, indexHandler = null)->
    $addNew = new AddNewUl(elem, indexHandler);
    $addNew.initialize();

  init : ->
    self = @;

    self.initList();
    return;

}

AddNew.init();

window.RowManager = AddNew;