updateCountdown = ->
	maxchars = 140
	ambervalue = 21
	redvalue = 11
	remaining = maxchars - jQuery("#micropost_content").val().length
	jQuery(".countdown").text remaining + " remaining"
	jQuery(".countdown").css "color", (if (maxchars >= remaining >= ambervalue) then "gray")
	jQuery(".countdown").css "color", (if (ambervalue >= remaining >= redvalue) then "orange")
	jQuery(".countdown").css "color", (if (redvalue > remaining) then "red")

jQuery ->
	jQuery('#new_micropost').append '<span class="countdown"></span>'
	updateCountdown()
	$("#micropost_content").on 'input', updateCountdown
