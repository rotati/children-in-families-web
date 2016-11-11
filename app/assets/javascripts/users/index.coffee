CIF.UsersIndex = do ->
  _init = ->
    _fixedHeaderTableColumns()
    _handleScrollTable()

  _fixedHeaderTableColumns = ->
    $('.users-table').removeClass('table-responsive')
    if !$('table.users tbody tr td').hasClass('noresults')
      $('table.users').dataTable(
        'bPaginate': false
        'bFilter': false
        'bInfo': false
        'bSort': false
        'sScrollY': 'auto'
        'bAutoWidth': true
        'sScrollX': '100%'
        'sScrollXInner': '100%')
    else
      $('.users-table').addClass('table-responsive')

  _handleScrollTable = ->
    $(window).load ->
      $('.users-table .dataTables_scrollBody').niceScroll()

  { init: _init }
