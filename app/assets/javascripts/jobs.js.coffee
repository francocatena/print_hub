window.Jobs =
  listenRangeChanges: (itemClass)->
    $(document).on 'keyup', 'input[name$="[range]"]', ->
      element = $(this)
      [validRanges, maxPage, rangePages] = [true, null, 0]
      pages = parseInt element.parents(itemClass).find('input[name$="[pages]"]').val()
      ranges = element.val().trim().split(/\s*,\s*/).sort (r1, r2)->
        r1Value = parseInt(r1.match(/^\d+/)) || 0
        r2Value = parseInt(r2.match(/^\d+/)) || 0

        r1Value - r2Value

      $.each ranges, (i, r)->
        data = r.match /^(\d+)(-(\d+))?$/
        n1 = parseInt(data[1]) if data
        n2 = parseInt(data[3]) if data

        validRanges = validRanges && n1 && n1 > 0 && (!n2 || n1 < n2)
        validRanges = validRanges && (!maxPage || maxPage < n1)

        maxPage = n2 || n1
        rangePages += if n2 then n2 + 1 - n1 else 1

      if (/^\s*$/.test(element.val()) || validRanges) && (!pages || !maxPage || pages >= maxPage)
        element.parents('.control-group').removeClass('error')

        if /^\s*$/.test(element.val()) && pages
          element.data('rangePages', pages).trigger('change')
        else if !/^\s*$/.test(element.val()) && validRanges
          element.data('rangePages', rangePages).trigger('change')
      else
        element.parents('.control-group').addClass('error')
  
  listenTwoSidedChanges: (itemClass)->
    $(document).on 'change', 'input[name$="[two_sided]"]', ->
      Jobs.updatePricePerCopy(itemClass)
  
  updatePricePerCopy: (itemClass)->
    $('input[name$="[price_per_copy]"]').each (i, ppc)->
      twoSidedElement = $(ppc).parents("#{itemClass}:first")
      .find('input[name$="[two_sided]"].price-modifier')
      
      if twoSidedElement.is(':checked')
        setting = $('#total_pages').data('pricePerTwoSided')
      else
        setting = $('#total_pages').data('pricePerOneSided')

      $(ppc).val PriceChooser.choose(setting, parseInt($('#total_pages').val()))