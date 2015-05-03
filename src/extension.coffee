$                 = require 'jquery'
{ openAppWindow } = require './core.coffee'

console.log 'The extension has been injected.'

iTunesRegexes = [
  /.*itunes\.apple.com\/.*\app\/.*/
  /.*appsto\.re\/.*/
]

matchesAnyItunesRegex = (target) ->
  iTunesRegexes.some (regex, index, array) ->
    regex.test target


$(document).on 'click', 'a', (event) ->
  linkTarget = $(this).attr('href')
  linkName = $(this).text()

  if matchesAnyItunesRegex(linkTarget) or matchesAnyItunesRegex(linkName)
    console.log 'Intercepting link text:' + linkName + ', href:' + linkTarget
    openAppWindow linkTarget
    event.preventDefault()
