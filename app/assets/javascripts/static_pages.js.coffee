# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`$(document).ready(function () { 
	$("#micropost_content").jqEasyCounter({
		'maxChars' 					: 140,
		'maxCharsWarning'		:	120,
		'msgWarningColor'		: '#F00'
	});
});`