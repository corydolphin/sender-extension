{ openAppWindow } = require './core.coffee'

if chrome?
  console.log "Chrome injection running"

  onRedirectHandler = (details) ->
    redirectUrl: "https://sendthistome.com/install?link=#{details.url}"

  chrome.webRequest.onBeforeRequest.addListener(
    onRedirectHandler,
    {urls: ["https://itunes.apple.com/*"]},
    ["blocking"]
  )

  chrome.contextMenus.create
    title: 'Send to mobile'
    contexts: [ 'link' ]
    id: 'context sendToMobile'

  chrome.contextMenus.onClicked.addListener (info, tab) ->
    console.log "ContextMenu clicked info: #{JSON.stringify info}"
    openAppWindow info.linkUrl
