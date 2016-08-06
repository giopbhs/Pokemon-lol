// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require masonry/jquery.masonry
//= require bootstrap-sprockets
//= require jquery.bind_with_delay
//= require yt_player
//= require_tree .


###!
# classie - class helper functions
# from bonzo https://github.com/ded/bonzo
# 
# classie.has( elem, 'my-class' ) -> true/false
# classie.add( elem, 'my-new-class' )
# classie.remove( elem, 'my-unwanted-class' )
# classie.toggle( elem, 'my-class' )
###

###jshint browser: true, strict: true, undef: true ###

###global define: false ###

do (window) ->
  # class helper functions from bonzo https://github.com/ded/bonzo

  classReg = (className) ->
    new RegExp('(^|\\s+)' + className + '(\\s+|$)')

  toggleClass = (elem, c) ->
    fn = if hasClass(elem, c) then removeClass else addClass
    fn elem, c
    return

  'use strict'
  # classList support for class management
  # altho to be fair, the api sucks because it won't accept multiple classes at once
  hasClass = undefined
  addClass = undefined
  removeClass = undefined
  if 'classList' of document.documentElement

    hasClass = (elem, c) ->
      elem.classList.contains c

    addClass = (elem, c) ->
      elem.classList.add c
      return

    removeClass = (elem, c) ->
      elem.classList.remove c
      return

  else

    hasClass = (elem, c) ->
      classReg(c).test elem.className

    addClass = (elem, c) ->
      if !hasClass(elem, c)
        elem.className = elem.className + ' ' + c
      return

    removeClass = (elem, c) ->
      elem.className = elem.className.replace(classReg(c), ' ')
      return

  classie = 
    hasClass: hasClass
    addClass: addClass
    removeClass: removeClass
    toggleClass: toggleClass
    has: hasClass
    add: addClass
    remove: removeClass
    toggle: toggleClass
  # transport
  if typeof define == 'function' and define.amd
    # AMD
    define classie
  else
    # browser global
    window.classie = classie
  return
# EventListener | @jon_neal | //github.com/jonathantneal/EventListener
!window.addEventListener and window.Element and do ->
  registry = []

  addToPrototype = (name, method) ->
    Window.prototype[name] = HTMLDocument.prototype[name] = Element.prototype[name] = method
    return

  addToPrototype 'addEventListener', (type, listener) ->
    target = this
    registry.unshift
      __listener: (event) ->
        event.currentTarget = target
        event.pageX = event.clientX + document.documentElement.scrollLeft
        event.pageY = event.clientY + document.documentElement.scrollTop

        event.preventDefault = ->
          event.returnValue = false
          return

        event.relatedTarget = event.fromElement or null

        event.stopPropagation = ->
          event.cancelBubble = true
          return

        event.relatedTarget = event.fromElement or null
        event.target = event.srcElement or target
        event.timeStamp = +new Date
        listener.call target, event
        return
      listener: listener
      target: target
      type: type
    @attachEvent 'on' + type, registry[0].__listener
    return
  addToPrototype 'removeEventListener', (type, listener) ->
    index = 0
    length = registry.length
    while index < length
      if registry[index].target == this and registry[index].type == type and registry[index].listener == listener
        return @detachEvent('on' + type, registry.splice(index, 1)[0].__listener)
      ++index
    return
  addToPrototype 'dispatchEvent', (eventObject) ->
    `var index`
    `var length`
    try
      return @fireEvent('on' + eventObject.type, eventObject)
    catch error
      index = 0
      length = registry.length
      while index < length
        if registry[index].target == this and registry[index].type == eventObject.type
          registry[index].call this, eventObject
        ++index
    return
  return

# ---
# generated by js2coffee 2.2.0