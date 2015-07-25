# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.getUser = (id) ->
	$("#user_data tbody").html('')
	$.ajax(url: "/users/" + id).done (json) ->
		$("#user_data").append "<tr><td>" + json.name + "</td></tr>"
		$("#user_data").append "<tr><td>" + json.line1 + "</td></tr>"
		if json.line2
			$("#user_data").append "<tr><td>" + json.line2 + "</td></tr>"
		$("#user_data").append "<tr><td>" + json.city + ", " + json.state + " " + json.zip + "</td></tr>"
		$("#user_data").append "<tr><td>" + json.phone + "</td></tr>"

root.filterUsers = () ->
	filter_text = $("#filter").val()
	$("#all_users tr:contains('" + filter_text + "')").show()
	$("#all_users tr:not(:contains('" + filter_text + "'))").hide()
