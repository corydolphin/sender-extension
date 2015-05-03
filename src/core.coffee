getRedirectLink = (installLink) ->
  "https://sendthistome.com/install?link=#{encodeURIComponent installLink}"

module.exports =
  openAppWindow: (installLink) ->
    window.open(
      getRedirectLink(installLink),
      'Installer',
      'width=500,height=500'
    )

