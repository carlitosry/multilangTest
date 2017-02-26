Select = (select) ->
  props = {
    target : do ->
        target = if select.data('chain-target') then  $('.' + select.data('chain-target')) else null;
        return if target then SelectFactory.get(target) else target;

    firstOpt : do -> $('option:first', select).clone(),
    select: select,

    getValue : ->
      return select.val();

    clean : ->
      select.html(@firstOpt.clone());
      return @;

    loading : ->
      select.html( $('<option>').html('Cargando...') );
      @cleanChildren();
      return @;

    cleanChildren : () ->
      child = @target;
      if child
        child.clean();
        if(child.target)

          child.cleanChildren();
          return
        return;

    createOption : (row) ->
      return $('<option>').val(row.id).html(row.name);

    fill : (data) ->
      @target.clean();
      @target.select.append @createOption row for row in data;
      return;

  };

  return props;

SelectFactory = {

  set : (select, obj) ->
    select.data('select', obj);

  get : (select) ->
    obj = select.data('select');

    if(!obj)
      obj = new Select(select);
      @set(select, obj);

    return obj;

}


ChainedSelects = (options) ->
  defaultoptions = {
    selector : 'select[data-chain-target]',
    routeName: 'select[data-route]'
  };

  options = $.extend(defaultoptions, options);

  obj = {
    getUrl: (id) ->
      return Routing.generate(options.routeName, {id: id});

    changeHandler: ->
      self = @;
      $(options.selector).on('change', () ->
        select = SelectFactory.get($(@));

        console.log select.select

        route = $(select.select).data('route');
        options.routeName = route;

        if(select.getValue())
          url = self.getUrl(select.getValue());
          select.target.loading();

          App.ajax.get(url, null, (data)->
            select.fill(data);
          );
        else
          select.cleanChildren();

      );

      return;

    init : ->
      self = @;
      self.changeHandler();
  };

  obj.init();
  return;

ChainedSelects();