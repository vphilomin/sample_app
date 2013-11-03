updateCountdown = (content, countdown) ->
	maxchars = 140
	ambervalue = 21
	redvalue = 11
	remaining = maxchars - content.val().length
	countdown.text remaining + " remaining"
	countdown.css "color", (if (maxchars >= remaining >= ambervalue) then "gray")
	countdown.css "color", (if (ambervalue >= remaining >= redvalue) then "orange")
	countdown.css "color", (if (redvalue > remaining) then "red")

$(document).on "input", "#micropost_content", ->
	content = $("#micropost_content")
	countdown = $(".countdown")
	updateCountdown(content, countdown)

injectCountdown = ->
	$("#new_micropost").append '<span class="countdown">140 remaining</span>' if $("#new_micropost").length

$(document).ready(injectCountdown)
$(document).on('page:load', injectCountdown)	